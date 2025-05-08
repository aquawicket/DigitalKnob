#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_dirname(path, rtn_var)
#
#    https://en.wikipedia.org/wiki/Dirname
#
dk_dirname() {
	dk_debugFunc 1 2
	
	local dk_dirname=$(dirname "${1}")
	
	### return value ###
	dk_call dk_printVar dk_dirname
	[ ${#} -gt 1 ] && eval "${2}=${dk_dirname}" && return  # return value when using rtn_var parameter 
	dk_return ${dk_dirname}; return						  # return value when using command substitution 
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_dirname=$(dk_call dk_dirname "/path/to/a/filename.txt")
	dk_call dk_echo "dk_dirname = ${dk_dirname}"
	
	dk_call dk_dirname "/path/to/a/filename.txt" dk_dirname
	dk_call dk_echo "dk_dirname = ${dk_dirname}"
}
