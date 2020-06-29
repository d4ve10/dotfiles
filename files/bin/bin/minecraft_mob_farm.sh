#!/bin/bash
counter=0
while :
do
	counter=$((counter+1))
	xdotool click --window $(xdotool search --name "Minecraft ") 1
	if [ $(( counter % 400 )) == 0 ]
	then
		xdotool mousedown --window $(xdotool search --name "Minecraft ") 3
		sleep 1.6
		xdotool mouseup --window $(xdotool search --name "Minecraft ") 3
	fi
	sleep 0.75
done
