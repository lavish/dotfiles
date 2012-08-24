#!/bin/dash

pre=''
post=''
state=$(cat /sys/devices/platform/smapi/BAT0/state)

case $state in
	discharging)	out="-"$(cat /sys/devices/platform/smapi/BAT0/remaining_running_time)
			pre='<fc=#cccccc>'
			post='</fc>' ;;
	charging)	out="+"$(cat /sys/devices/platform/smapi/BAT0/remaining_charging_time) ;;
	*)		out=$state ;;
esac

percent_left=$(($(cat /sys/devices/platform/smapi/BAT0/remaining_percent)/10))

case $percent_left in
	0)	bar='·····'
		pre='<fc=#c80000>'
		post='</fc>' ;;
	1|2)	bar='|····'
		pre='<fc=#c80000>'
		post='</fc>' ;;
	3|4)	bar='||···' ;;
	5|6)	bar='|||··' ;;
	7|8)	bar='||||·' ;;
	9|10)	bar='|||||' ;;
	*)	bar='-----' ;;
esac

echo $pre$out $bar$post

exit 0
