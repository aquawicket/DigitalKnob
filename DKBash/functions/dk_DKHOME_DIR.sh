#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

####################################################################
# dk_DKHOME_DIR()
#
#
dk_DKHOME_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKHOME_DIR="${1}" 
		return 0
	fi
		
	############ GET ############
    [ -e "${DKHOME_DIR-}" ] 	&& return 0 	# already exists
    	
	###### CMD_EXE ######
	[ ! -e "${CMD_EXE-}" ]		&& export CMD_EXE=$(command -v cmd.exe) || $(true)
	[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE="C:/Windows/System32/cmd.exe"
	[ ! -e "${CMD_EXE}" ]		&& unset CMD_EXE
	[   -e "${CMD_EXE-}" ]		&& dk_call dk_printVar CMD_EXE
	
	######  USERPROFILE -> CYGPATH_EXE -> DKHOME_DIR ######
	[ ! -e "${CYGPATH_EXE-}" ]	&& export CYGPATH_EXE=$(command -v "cygpath") || $(true)
	[   -e "${CYGPATH_EXE}" ]	&& export USERPROFILE=$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
	[ ! -e "${CYGPATH_EXE}" ]	&& unset CYGPATH_EXE
	[   -e "${CYGPATH_EXE-}" ]	&& dk_call dk_printVar CYGPATH_EXE
	[   -e "${CYGPATH_EXE-}" ]	&& export DKHOME_DIR=$(cygpath -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
	
	######  USERPROFILE -> WSLPATH_EXE -> DKHOME_DIR ######
	[ ! -e "${WSLPATH_EXE-}" ]	&& export WSLPATH_EXE=$(command -v "wslpath") || $(true)
	[   -e "${WSLPATH_EXE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
	[ ! -e "${WSLPATH_EXE}" ]	&& unset WSLPATH_EXE
	[   -e "${WSLPATH_EXE-}" ]	&& dk_call dk_printVar WSLPATH_EXE
	[   -e "${WSLPATH_EXE-}" ]	&& export DKHOME_DIR=$(wslpath -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
	
	### DKHOME_DIR ###
#	[ ! -e "${DKHOME_DIR-}" ]   && [ -e "$(grep -o "/storage/....-...." /proc/mounts)" ] && export DKHOME_DIR=$(grep -o "/storage/....-...." /proc/mounts) # Android sdcard
	[ ! -e "${DKHOME_DIR-}" ] 	&& export DKHOME_DIR="${HOME}"
	[ ! -e "${DKHOME_DIR}" ] 	&& 	dk_call dk_fatal "DKHOME_DIR not found"

	true
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKHOME_DIR . . ."
    dk_call dk_DKHOME_DIR
    dk_call dk_printVar DKHOME_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKHOME_DIR . . ."
	dk_call dk_DKHOME_DIR "/C/"
	dk_call dk_printVar DKHOME_DIR 
}
