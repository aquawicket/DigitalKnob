# dk_include_guard()

##################################################################################
# dk_verbose(<message>)
#
#
dk_verbose () {
	#dk_verbose "dk_verbose($*)"
	[ -z "$1" ] && dk_error "dk_verbose($*): requires at least 1 parameter"
	
	[ $LOG_VERBOSE = 1 ] || return 0

	dk_echo "${cyan}VERBOSE: $1 ${clr}"
}