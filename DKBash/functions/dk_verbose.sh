# dk_include_guard()


[ -z ${LOG_VERBOSE-} ] && LOG_VERBOSE=1
DKVERBOSE_TAG="BASH VERBOSE: "
##################################################################################
# dk_verbose(<message>)
#
#
dk_verbose () {
	#dk_echo "${cyan}dk_verbose($*)${clr}"
	[ $# -lt 1 ] && dk_error "dk_verbose($*): requires at least 1 parameter"
	
	[ $LOG_VERBOSE = 1 ] || return 0
	verbose_msg="$1"
	dk_to_variable_info verbose_msg
	dk_echo "${cyan}${DKVERBOSE_TAG}${verbose_msg}${clr}"
}