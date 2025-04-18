#!/usr/bin/python
from dbus_next.aio import MessageBus
from dbus_next.constants import BusType
import asyncio
BLUEZ = "org.bluez"
#replace hci0 with your bluetooth adapter name and FF_FF_FF_FF_FF_FF with your keyboard address
BLUEZ_PATH = "/org/bluez/hci0/dev_F4_3D_92_67_06_5E"
GATT_SERVICE = 'org.bluez.GattService1'
GATT_CHARACTERISCITC = 'org.bluez.GattCharacteristic1'
GATT_CHARACTERISCITC_DESCR = 'org.bluez.GattDescriptor1'
BATTERY_UUID = "0000180f-0000-1000-8000-00805f9b34fb"
BATTERY_LEVEL_UUID = "00002a19-0000-1000-8000-00805f9b34fb"
BATTERY_USER_DESC = "00002901-0000-1000-8000-00805f9b34fb"

out = "  "

async def main():
    try:
        bus = await MessageBus(bus_type=BusType.SYSTEM).connect()
        # the introspection xml would normally be included in your project, but
        # this is convenient for development
        introspection = await bus.introspect(BLUEZ, BLUEZ_PATH)

        device = bus.get_proxy_object(BLUEZ, BLUEZ_PATH, introspection)

        for svc in device.child_paths:
            intp = await bus.introspect(BLUEZ, svc)
            proxy = bus.get_proxy_object(BLUEZ, svc, intp)
            intf = proxy.get_interface(GATT_SERVICE)
            if BATTERY_UUID == await intf.get_uuid():
                for char in proxy.child_paths:
                    intp = await bus.introspect(BLUEZ, char)
                    proxy = bus.get_proxy_object(BLUEZ, char, intp)
                    intf = proxy.get_interface(GATT_CHARACTERISCITC)
                    level = int.from_bytes(await intf.call_read_value({}))
                    if BATTERY_LEVEL_UUID == await intf.get_uuid():
                        global out
                        out += f"{level}% "
    except:
        out += "Disconnected"

if __name__ == "__main__":
    asyncio.run(main())
    print(out)
