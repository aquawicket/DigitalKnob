#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_realpath(path, rtn_var)
#
#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
#    C: 	https://pubs.opengroup.org/onlinepubs/9699919799/functions/realpath.html
#
dk_realpath(){
	dk_debugFunc 1 2
	#[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${*}): not enough arguments"
	#[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${*}): too many arguments"
	
	local _realpath_=""
	if dk_commandExists realpath; then
		_realpath_=$(realpath "${1}")
	elif dk_commandExists readlink; then
		$(dk_readlink -f "${1}") && _realpath_=$(dk_readlink -f "${1}") || _realpath_=$(dk_readlink "${1}") #dk_fixme("MacOS readlink has no -f parameter")
	else	
		_realpath_=$(cd $(dk_dirname ${1}); pwd -P)/$(dk_basename ${1})
	fi
	
	### return value ###
	dk_printVar _realpath_
	[ ${#} -gt 1 ] && eval "${2}=${_realpath_}" && return  # return value when using rtn_var parameter 
	dk_return ${_realpath_}; return						  # return value when using command substitution 
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	#dk_debugFunc 0
	
	realpathA=$(dk_realpath "dk_load.sh")
	dk_echo "realpathA = ${realpathA}"
	
	dk_realpath "dk_load.sh" realpathB
	dk_echo "realpathB = ${realpathB}"
}