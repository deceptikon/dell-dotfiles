#!/bin/bash
EXTERNAL_OUTPUT="eDP1"
INTERNAL_OUTPUT="HDMI1"
NEOVO_OUTPUT="DP1"

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="work"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "work" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
# elif [ $monitor_mode = "INTERNAL" ]; then
#        monitor_mode="CLONES"
#        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="domestic"
        xrandr --output $EXTERNAL_OUTPUT --auto --output $NEOVO_OUTPUT --auto --left-of $EXTERNAL_OUTPUT
else
        monitor_mode="work"
        xrandr --output $EXTERNAL_OUTPUT --auto --output $INTERNAL_OUTPUT --auto --right-of $EXTERNAL_OUTPUT
fi
feh --recursive --randomize --bg-scale ~/Pictures/wallpapers
echo "${monitor_mode}" > /tmp/monitor_mode.dat
