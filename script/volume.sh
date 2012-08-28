#!/bin/dash

vol=$(amixer get PCM | awk -F'[]%[]' '/Left: / {if ($7 == "off") { print "MM" } else { print int($2/10)}}')

case $vol in
	0)     bar='·····' ;;
	1|2)   bar='<fc=#cccccc>|····</fc>' ;;
	3|4)   bar='<fc=#cccccc>||···</fc>' ;;
	5|6)   bar='<fc=#cccccc>|||··</fc>' ;;
	7|8)   bar='<fc=#f6283c>||||·</fc>' ;;
	9|10)  bar='<fc=#f6283c>|||||</fc>' ;;
	*)     bar='-----' ;;
esac

echo $bar

exit 0;
