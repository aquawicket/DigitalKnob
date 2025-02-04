#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

# this overwrites the echo command with our own, and call the built-in.
# https://unix.stackexchange.com/a/241060
# https://linuxcommand.org/lc3_man_pages/echoh.html
##################################################################################
# dk_builtins()
#
#
dk_builtins() {
	dk_debugFunc 0

	# call builtin echo exmple
	builtin echo -n -e "DK: ${@}\n"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_debug "DKTEST(${DKSCRIPT_NAME})"
}
