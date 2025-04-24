<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_confirm()
#
#
dk_confirm() {
	dk_debugFunc 0

	dk_call dk_echo "${yellow} Are you sure ? [Y/N] ${clr}"
	read -rp $" " REPLY
	dk_call dk_echo
	dk_call dk_echo
	#result=$(builtin echo ${REPLY} | grep "^[Yy]$")
	[ "${REPLY}" = "y" ] && return $(true)
	[ "${REPLY}" = "Y" ] && return $(true)
	return $(false)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	if dk_call dk_confirm; then 
		dk_call dk_echo "the confimation has passed"
	else
		dk_call dk_echo "the confimation has failed"
	fi
}