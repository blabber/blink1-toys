#!/bin/sh

# "THE BEER-WARE LICENSE" (Revision 42):
# <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.

usage() {
	echo "$0 [-t fade_in seconds] [-m max_color_value]" >&2
	echo "$0 -h" >&2
	echo "" >&2
	echo "Example: $0 -t 5 -m 150 ~/bin/blink1-tool" >&2
}

while getopts "ht:m:" opt; do
	case "$opt" in
	h)	usage
		exit 0
		;;
	t)	FADETIME="$OPTARG"
		;;
	m)	MAXCOLOR="$OPTARG"
		;;
	*)	usage
		exit 1
		;;
	esac
done

BLINKTOOL=$(which blink1-tool)
if [ -z "$BLINKTOOL" ]; then
	echo "could not find blink1-tool" >&2
	exit 1
fi

: ${FADETIME:=5}
: ${MAXCOLOR:=255}

RED="$MAXCOLOR,0,0"
GREEN="0,$MAXCOLOR,0"
BLUE="0,0,$MAXCOLOR"

while true; do
	"$BLINKTOOL" -m "${FADETIME}000" --rgb "$RED"
	sleep "$FADETIME"
	"$BLINKTOOL" -m "${FADETIME}000" --rgb "$GREEN"
	sleep "$FADETIME"
	"$BLINKTOOL" -m "${FADETIME}000" --rgb "$BLUE"
	sleep "$FADETIME"
done
