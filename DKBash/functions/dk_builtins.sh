#!/bin/sh
#echo "$0($*)"

# this overwrites the echo command with our own, and call the built-in.
# https://unix.stackexchange.com/a/241060
# https://linuxcommand.org/lc3_man_pages/echoh.html

#echo () {
#	dk_debugFunc
#	builtin echo -n -e "DK: $@\n"
#}