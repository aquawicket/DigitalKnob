#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


###############################################################################
# dk_validate(variable, code) NO_HALT
#
#    Check if a variable is valid, otherwise run code to validate the variable
#
dk_validatePath() {
    dk_debugFunc 2

	[ -e "${1-}" ] && return
	[ -e "${!1-}" ] && return
    # dk_call dk_contains "$2" "dk_call" || dk_call dk_error "dk_validate parameter 2 requires the use of dk_call"
    
	eval "${2}"
    
	[ "${3-}" = "NO_HALT" ] && return
    [ -n "${1-}" ] || dk_call dk_error "dk_validatePath was unable to set the path variable:${1-} with the code provided"
	[ -e "${!1-}" ] || dk_call dk_error "dk_validatePath was unable to locate the path:${!1-} with the code provided"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_validatePath DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
    dk_call dk_echo "DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}"
	
	dk_call dk_validatePath DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
    dk_call dk_echo "DKTOOLS_DIR = ${DKTOOLS_DIR}"
	
	dk_call dk_validatePath DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
    dk_call dk_echo "DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}"
	
#	dk_call dk_validatePath NONEXISTENT_DIR "dk_call dk_DKDOWNLOAD_DIR"
#   dk_call dk_echo "NONEXISTENT_DIR = ${NONEXISTENT_DIR}"
}
