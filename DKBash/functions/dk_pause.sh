#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_pause(pause_msg)
#
#	Pause execution and wait for keypress to continue
#
dk_pause() {
	dk_debugFunc 0 1

	[ -z "${1-}" ] && pause_msg="Press enter to continue..." || pause_msg="${1}"
	#read -rp 'Press enter to continue...'; # key; echo ${key}
	echo "${pause_msg}"
	read -rp ''
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_pause
	dk_pause "Pause with a custom message"
	dk_pause "${red}Pause ${green}with ${blue}colorful ${yellow}message${clr}"
	dk_echo  "pause with no message"
	dk_pause " "
}
