# dk_include_guard()

##################################################################################
# dk_error(<message>)
#
#
dk_error () {
	#dk_verbose "dk_error($*)"
	
	msg="$1"
	dk_to_variable_info msg
	dk_echo "${red}  ERROR: ${msg} ${clr}"
	dk_stacktrace
	[ $CONTINUE_ON_ERRORS = 1 ] && return 0
	dk_wait_for_key
	exit 1
}