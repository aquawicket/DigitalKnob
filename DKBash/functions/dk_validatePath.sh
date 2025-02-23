#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_validate(variable, code) NO_HALT
#
#    Check if a variable is valid, otherwise run code to validate the variable
#
dk_validatePath() {
    dk_debugFunc 2

	[ -e "${1-}" ] && return
	[ -e "${!1-}" ] && return
    # dk_call dk_stringContains "$2" "dk_call" || dk_call dk_error "dk_validate parameter 2 requires the use of dk_call"
    
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
