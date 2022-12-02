#!/bin/sh

dbus-update-activation-environment DISPLAY=:0
wall "由于内存不足，earlyoom 已杀死一些进程以保证用户界面流畅。如果多次看到此消息，请联系管理员添加内存。"
timeout -k 2 sudo -u ubuntu DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" notify-send "由于内存不足，earlyoom 已杀死一些进程以保证用户界面流畅。如果多次看到此消息，请联系管理员添加内存。"
