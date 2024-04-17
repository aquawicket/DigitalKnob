# dk_include_guard()

##################################################################################
# dk_debug(<message>)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug () {
	#dk_verbose "dk_debug($*)"	
	[ $# -lt 1 ] && dk_error "dk_debug($*): requires at least 1 parameter"
	
	[ $LOG_DEBUG -eq 1 ] || return 0
	
	msg="$1"
	dk_to_variable_info msg
	dk_echo "${blue}  DEBUG: ${msg} ${clr}"
}