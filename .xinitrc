#!/bin/sh
userresources=$HOME/.config/.Xresources
usermodmap=$HOME/.config/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
udiskie &
systemctl --user start opentabletdriver.service

setxkbmap -layout us

xrandr --output HDMI-0 --auto --rotate left --pos 0x0
xrandr --output DP-4 --auto --primary --pos 1080x430

xrandr --setmonitor vertical auto HDMI-0
xrandr --setmonitor horizontal auto DP-4

xset s off s noblank -dpms

exec i3
