#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_test(<arg1> <ret_val>)
#
#
dk_test() {
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	[ $# -gt 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	dk_info "test from dk_info"
	dk_debug "test from dk_debug"
	
	echo "__FILE__     = $(__FILE__)"
	echo "__LINE__     = $(__LINE__)"
	echo "__FUNCTION__ = $(__FUNCTION__)"
	echo "__ARGC__     = $(__ARGC__)"
	echo "__ARGV__     = $(__ARGV__)"
	echo "__CALLER__   = $(__CALLER__)"

	echo "input = $1"
	#dk_return "$2" "output string variable"
	local ret_val="${2-}"
	dk_return "output string variable"
}


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	### using return variable ###
	input="input string variable (return variable)"
	dk_test "$input" output
	echo "output = ${output}"
	
	### using command substitution for return variable ###
	input="input string variable (command substitution return)"
	output=$(dk_test "$input")
	echo "output = ${output}"
}