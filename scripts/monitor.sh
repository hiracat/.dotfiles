#!/bin/sh

if [ $1 = "off" ]; then
    sleep 1
    hyprctl dispatch dpms off
fi

if [ $1 = "on" ]; then
    sleep 1
    hyprctl dispatch dpms on
fi
