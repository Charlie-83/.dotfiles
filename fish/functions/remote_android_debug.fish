function remote_android_debug
    echo "Make sure phone is plugged in via USB"
     
    echo "Clearing old state."
    adb kill-server
    adb start-server
    sleep 4
     
    echo "Getting the phone's IP address on the wifi network."
    set ip (adb -d shell "ip a" | grep 'inet.*wlan' | awk '{print $2}' | sed 's_/24__' | sed 's_/8__')
    if [ -z "$ip" ]
        echo "Couldn't get IP address of phone. Are you sure it is plugged in via USB and is connected to your Wifi network?"
        exit 1
    end
     
    echo "IP is $ip"
     
    echo "Telling the phone to accept debug connections on port 4444."
    adb tcpip 4444
     
    echo "Connecting adb server to the phone via Wifi."
    adb connect $ip:4444
     
    echo "Done. Unplug the USB lead."
end
