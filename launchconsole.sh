#!/bin/bash

# find tty lines
available_tty=$(ls -l /dev/tty* | grep dialout | grep -E -o "tty(ACM|USB).")

# If none found, provide some info and exit
if [ -z "$available_tty" ]; then
 dmesg | grep -E "tty(ACM|USB)" && echo
 lsusb && echo
 echo "No tty lines found.  Was the cable removed?"
 exit 0
fi

# Connect to all available tty lines.
# Use the default bybou session & create a tab connecting to the tty line
for i in $available_tty; do
 screen -S byobu -X screen -t "$i" /dev/"$i" 9600
done
