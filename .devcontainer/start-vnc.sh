#!/bin/bash

Xvfb :1 -screen 0 1280x720x24+32 &
export DISPLAY=:1

x11vnc -forever -shared -rfbport 5901 -display :1 &

cd /opt && ./utils/launch.sh --listen 6080 --vnc localhost:5901
