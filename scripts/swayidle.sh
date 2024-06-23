#!/bin/sh

swayidle -w timeout 300 'swaylock --daemonize' timeout 360 "systemctl suspend" &
