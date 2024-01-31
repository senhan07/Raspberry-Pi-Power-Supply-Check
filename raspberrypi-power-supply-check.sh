#!/bin/bash

function throttleCodeMask {
  perl -e "printf \"%s\", $1 & $2 ? \"$3\" : \"$4\""
}

function throttledToText {
  throttledCode=$1
  throttleCodeMask $throttledCode 0x80000 "Soft temperature limit has occurred, " ""
  throttleCodeMask $throttledCode 0x40000 "Throttling has occurred, " ""
  throttleCodeMask $throttledCode 0x20000 "Arm frequency capping has occurred, " ""
  throttleCodeMask $throttledCode 0x10000 "Under-voltage has occurred, " ""
  throttleCodeMask $throttledCode 0x8 "Soft temperature limit active, " ""
  throttleCodeMask $throttledCode 0x4 "Currently throttled, " ""
  throttleCodeMask $throttledCode 0x2 "Arm frequency capped, " ""
  throttleCodeMask $throttledCode 0x1 "Under-voltage detected, " ""
}

# Main script, kill sysbench when interrupted
trap 'kill -HUP 0' EXIT
sysbench cpu --cpu-max-prime=10000000 --num-threads=4 run > /dev/null &
maxfreq=$(( $(awk '{printf ("%0.0f",$1/1000); }' < /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq) -15 ))

# Read sys info, print and loop
while true; do
  temp=$(vcgencmd measure_temp | cut -f2 -d=)
  real_clock_speed=$(vcgencmd measure_clock arm | awk -F"=" '{printf ("%0.0f", $2 / 1000000); }' )
  sys_clock_speed=$(awk '{printf ("%0.0f",$1/1000); }' </sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
  voltage=$(vcgencmd measure_volts | cut -f2 -d= | sed 's/000//')
  throttled_text=$(throttledToText $(vcgencmd get_throttled | cut -f2 -d=))
  echo "$temp $sys_clock_speed / $real_clock_speed MHz $voltage - $throttled_text"
  sleep 5
done
