#!/bin/bash

echo -e "*** TEST HTTP MIRRORS ***\n"

hosts=()
speeds=()

while read line; do
    host=$(echo $line | cut -d'/' -f1)
    path=$(echo $line | cut -d'/' -f2-)
    speed=$(curl --connect-timeout 5 -o /dev/null -s -w '%{speed_download}\n' $host)
    hosts+=($host)
    speeds+=($speed)
    echo $host.....$speed
done

max=${speeds[0]}
max_idx=0

for i in "${!speeds[@]}"; do
    if (( $(echo "${speeds[i]} > $max" | bc -l) )); then
        max=${speeds[i]}
        max_idx=$i
    fi
done

echo -e "\n*** MAX SPEED ***"
echo "host: ${hosts[$max_idx]}"
echo "speed: $max pack/sec"

