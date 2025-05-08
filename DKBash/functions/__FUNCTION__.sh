#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# __FUNCTION__(<frame>)
#
__FUNCTION__() {
	#dk_debugFunc 0 1
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=${1}

	dk_return "${FUNCNAME[${_FRAME_}]}"; return
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc 0
	
	echo "$(__FUNCTION__)"
}