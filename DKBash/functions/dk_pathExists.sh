#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_pathExists(<file>)
#
#
dk_pathExists() {
	dk_debugFunc 1


	[ -e "${1}" ]
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	if dk_pathExists "dk_debug.sh"; then
		echo "The path exists"
	else
		echo "The path does NOT exist"
	fi
	
	if dk_pathExists "nofile.ext"; then
		echo "The path exists"
	else
		echo "The path does NOT exist"
	fi
	
	if dk_pathExists "$PWD"; then
		echo "The path exists"
	else
		echo "The path does NOT exist"
	fi
}