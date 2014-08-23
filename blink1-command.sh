#!/bin/sh

# "THE BEER-WARE LICENSE" (Revision 42):
# <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.

usage() {
	echo "$0 [-m max_color_value] -c <command>" >&2
	echo "$0 -h" >&2
	echo "" >&2
	echo "Example: $0 -m 150 ~/bin/blink1-tool" >&2
}

while getopts "ht:m:c:" opt; do
	case "$opt" in
	h)	usage
		exit 0
		;;
	m)	MAXCOLOR="$OPTARG"
		;;
	c)	COMMAND="$OPTARG"
		;;
	*)	usage
		exit 1
		;;
	esac
done

if [ -z "$COMMAND" ]; then
	usage
	exit 1
fi

BLINKTOOL=$(which blink1-tool)
if [ -z "$BLINKTOOL" ]; then
	echo "could not find blink1-tool" >&2
	exit 1
fi

: ${MAXCOLOR:=255}

RED="$MAXCOLOR,0,0"
GREEN="0,$MAXCOLOR,0"
BLUE="0,0,$MAXCOLOR"

"$BLINKTOOL" --rgb "$BLUE"
sh -c "$COMMAND"

STATUS=$?
if [ $STATUS -eq 0 ]; then
	"$BLINKTOOL" --rgb "$GREEN"
else
	"$BLINKTOOL" --rgb "$RED"
fi

exit $STATUS
