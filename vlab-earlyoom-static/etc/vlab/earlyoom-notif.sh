#!/bin/bash

MSG="由于内存不足，earlyoom 已结束进程 $EARLYOOM_NAME 以保证用户界面流畅。如果多次看到此消息，请联系管理员添加内存。"

RATELIMIT="/tmp/earlyoom-ratelimit"

(
    flock -x 200 -w 2
    if [ -f "$RATELIMIT" ]; then
        CURRENT=$(date +%s)
        FILE=$(stat -c %Y "$RATELIMIT")

        DIFF=$((CURRENT-FILE))
        # 10 seconds rate-limit
        if [ "$DIFF" -lt 10 ]; then
            echo "Rate-limited earlyoom notification"
            exit 0
        fi
    fi
    touch "$RATELIMIT"
) 200>"$RATELIMIT"

wall "$MSG"
date >> /tmp/earlyoom-record
if ! command -v zenity &> /dev/null; then
    exit 0
fi

if id "ubuntu" &>/dev/null; then
    USER="ubuntu"
else
    USER="vlab"
fi

DISPLAY=:0 sudo -u "$USER" zenity --error --text "$MSG" &
