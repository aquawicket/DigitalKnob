#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_debugFunc()
#
#
alias dk_debugFunc='{
#####################################################################################################################
	if [ ${ENABLE_dk_debugFunc-0} -eq 1 ]; then
		
		local stack_size=${#FUNCNAME[@]}
		local -i i
		local indent=""
		for (( i = 4; i < stack_size; i++ )); do
			indent="${indent}   "
		done
		local indent="${indent} L "
		
		dk_echo "${cyan}[$(__TIME__)]${indent}$(__FILE__ 1):$(__LINE__ 1)  ${blue}$(__FUNCTION__ 1)($(__ARGV__ 1))${clr-}"
	fi
######################################################################################################################
}'


#func1() {
#	dk_debugFunc
#}
	
#DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
#	ENABLE_dk_debugFunc=1
#	dk_debugFunc
#	
#	func1 1 "2" '3'
#}
