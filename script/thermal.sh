#!/bin/dash

thm=$(awk '{print int($2/10) }' /proc/acpi/ibm/thermal)

case $thm in
	0)     bar='·····' ;;
	1|2)   bar='|····' ;;
	3|4)   bar='||···' ;;
	5|6)   bar='|||··' ;;
	7|8)   bar='<fc=#f6283c>||||·</fc>' ;;
	9|10)  bar='<fc=#f6283c>|||||</fc>' ;;
	*)     bar='-----' ;;
esac

echo $bar

exit 0
