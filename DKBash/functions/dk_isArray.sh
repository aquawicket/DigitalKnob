#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

#alias dkreturn='x(){ echo "${1}"; return "${1}" }; x'
##############################################################################
# dk_isArray(variable) -> rtn_var
# 
#	Test if arg1 is an array variable
#
#	@variable	- The variable to test
#	@rtn_var: 	- True if the argument is an array variable, false if otherwise
#
#	https://stackoverflow.com/a/27254437
#
dk_isArray() {
	dk_debugFunc 1
	
	[[ "$(declare -p ${1})" =~ "declare -a" ]] && return $(true)
	return $(false)
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myVar1=(1 2 3)
	dk_isArray myVar1 && dk_echo "myVar1 is an array" || dk_echo "myVar1 is NOT an array"
	
	#dk_echo "dk_isArray myVar1 = $(dk_isArray myVar1)"
	
	#if dk_isArray myVar1; then
	#	dk_echo "myVar1 is an array"
	#else
	#	dk_echo "myVar1 is NOT an array"
	#fi
	
	
	
	
	myVar2="a b c"
	dk_isArray myVar2 && dk_echo "myVar2 is an array" || dk_echo "myVar2 is NOT an array"
	
	#dk_echo "dk_isArray myVar2 = $(dk_isArray myVar2)"
	
	#if dk_isArray myVar2; then
	#	dk_echo "myVar2 is an array"
	#else
	#	dk_echo "myVar2 is NOT an array"
	#fi
}
