# dk_include_guard()


[ -z $LOG_DEBUG ] && LOG_DEBUG=1
DKDEBUG_TAG="  DEBUG: "
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
	debug_msg="$1"
	dk_to_variable_info debug_msg
	dk_echo "${blue}${DKDEBUG_TAG}${debug_msg}${clr}"
}