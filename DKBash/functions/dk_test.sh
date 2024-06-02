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
	
#	dk_info "test from dk_info"
#	dk_debug "test from dk_debug"
	
#	echo "__FILE__     = $(__FILE__)"
#	echo "__LINE__     = $(__LINE__)"
#	echo "__FUNCTION__ = $(__FUNCTION__)"
#	echo "__ARGC__     = $(__ARGC__)"
#	echo "__ARGV__     = $(__ARGV__)"
#	echo "__CALLER__   = $(__CALLER__)"

	if [[ $1 == *"[@]"* ]]; then
		local _input_=(${!1})
		echo "1 is an array variable"
		local _size_=${#_input_[@]}
		for ((i=0; i < $_size_; i++ )); do
			echo "_input_[$i] = ${_input_[$i]}";
		done
		echo "_input_ = ${_input_[@]}"
		echo "_size_ = ${_size_[@]}"
	fi
	
	dk_convertToCIdentifier "${1}" var
	if [ "${1}" = "${var}" ]; then
		if [ -n "${!1}" ]; then
			local _input_="${!1}"
			echo "1 is a variable"
		fi
	fi
	
	if [ -z "${_input_-}" ]; then
		local _input_="${1}"
		echo "1 is a string"
	fi
	
	echo "_input_ = $_input_"
	
	if [ $# -eq 2 ]; then
		local ret_val="${2-}"
		dk_return "sending back: $_input_"
	else
		dk_return "sending back: $_input_"
	fi
}


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	
	
	
	### (input:string output:return_var) ###
	dk_test "1 input:string" output
	echo "output:return_variable = ${output}"
	
	### (input:string output:$(command sub))
	output=$(dk_test "2 input:string")
	echo "output:command_sub_variable = ${output}"
	
	### (input:string_variable_value output:return_var) ###
	input="3 input:string_variable_value"
	dk_test "$input" output
	echo "output:return_variable = ${output}"
	
	### (input:string_variable_value output:$(command sub))
	input="4 input:string_variable_value"
	output=$(dk_test "$input")
	echo "output:command_sub_variable = ${output}"
	
	### (input:string_variable output:return_var) ###
	input="4 input:string_variable"
	dk_test input output
	echo "output:return_variable = ${output}"
	
	### (input:string_variable output:return_var) ###
	input="5 input:string_variable"
	output=$(dk_test input)
	echo "output:return_variable = ${output}"
	
	### (input:array_string_value output:return_var) ###
	arryA=("6" "array" "string" "value")
	arryA_str="${arryA[@]}"
	input="${arryA_str}"
	dk_test input output
	echo "output:return_variable = ${output}"
	
	### (input:array_variable[@] output:return_var) ###
	arryA=("7" "array" "variable" "direct")
	dk_test arryA[@] output
	echo "output:return_variable = ${output}"
	
	### (input:array_variable_value output:return_var) ###
	arryB=("8" "array" "variable" "by" "value")
	input=arryB[@]
	dk_test $input output
	echo "output:return_variable = ${output}"
	
	#####   FIXME   ########
#	### (input:array_variable_value output:return_var) ###
#	arryC=("7array" "array" "variable" "by" "name")
#	dk_test $arryC output
#	echo "output:return_variable = ${output}"
}