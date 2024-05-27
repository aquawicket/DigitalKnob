#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"
#[ -n "${dk_test-}" ] && exit || export readonly dk_test=1 
#shopt -s extdebug
#. "${DKSCRIPT_DIR}/__FILE__.sh"
#. "${DKSCRIPT_DIR}/__LINE__.sh"
#. "${DKSCRIPT_DIR}/__FUNCTION__.sh"
#. "${DKSCRIPT_DIR}/__ARGC__.sh"
#. "${DKSCRIPT_DIR}/__ARGV__.sh"
#. "${DKSCRIPT_DIR}/__CALLER__.sh"
##################################################################################
# dk_test(<args>)
#
#
dk_test() {
	dk_debugFunc
	
	dk_info "test from dk_info"
	dk_debug "test from dk_debug"
	
	echo "__FILE__     = $(__FILE__)"
	echo "__LINE__     = $(__LINE__)"
	echo "__FUNCTION__ = $(__FUNCTION__)"
	echo "__ARGC__     = $(__ARGC__)"
	echo "__ARGV__     = $(__ARGV__)"
	echo "__CALLER__   = $(__CALLER__)"

	echo "input = $1"
	local ret_val="${2-}"
	dk_return "output string variable"
}


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	input="input string variable (return variable)"
	dk_test "$input" output
	echo "output = ${output}"
	
	input="input string variable (command substitution return)"
	output=$(dk_test "$input")
	echo "output = ${output}"
}