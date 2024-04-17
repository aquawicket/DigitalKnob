# dk_include_guard()

##################################################################################
# dk_info(<message>)
#
#
dk_info () {
	#dk_verbose "dk_info($*)"
	
	msg="$1"
	dk_to_variable_info msg
	dk_echo "${white}   INFO: ${msg} ${clr}"
}