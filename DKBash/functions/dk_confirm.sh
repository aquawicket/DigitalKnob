#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


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