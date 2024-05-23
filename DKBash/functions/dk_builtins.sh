#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


# this overwrites the echo command with our own, and call the built-in.
# https://unix.stackexchange.com/a/241060
# https://linuxcommand.org/lc3_man_pages/echoh.html

##################################################################################
# dk_builtins()
#
#
dk_builtins () {
	dk_debugFunc
	
	# call builtin echo exmple
	builtin echo -n -e "DK: $@\n"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_debug "DKTEST(${DKSCRIPT_NAME})"
}