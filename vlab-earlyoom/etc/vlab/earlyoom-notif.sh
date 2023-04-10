#!/bin/sh

MSG="由于内存不足，earlyoom 已结束一些进程以保证用户界面流畅。如果多次看到此消息，请联系管理员添加内存。"

wall "$MSG"
timeout -k 2 5 sudo -u ubuntu zenity --error "$MSG"
