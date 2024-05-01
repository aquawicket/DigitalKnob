#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
dk_includeGuard

# this overwrites the echo command with our own, and call the built-in.
# https://unix.stackexchange.com/a/241060
# https://linuxcommand.org/lc3_man_pages/echoh.html

#echo () {
#	dk_debugFunc
#	builtin echo -n -e "DK: $@\n"
#}



################################ DKTEST #########################################
DKTEST () {
	#. ../functions/dk_builtins.sh
	echo "TODO"
}
[ -n "$DKTEST" ] && DKTEST