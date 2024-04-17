# dk_include_guard()

##################################################################################
# dk_warning(<message>)
#
#
dk_warning () {
	#dk_verbose "dk_warning($*)"
	
	msg="$1"
	dk_to_variable_info msg
	dk_echo "${yellow}WARNING: ${msg} ${clr}"
	[ ${TRACE_ON_WARNINGS-} = 1 ] && dk_stacktrace
	[ ${HALT_ON_WARNINGS-} = 1 ] && exit 1
}