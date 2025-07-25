#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
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
