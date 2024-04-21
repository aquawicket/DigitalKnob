# dk_include_guard()


[ -z ${TRACE_ON_WARNINGS-} ] && TRACE_ON_WARNINGS=0
[ -z ${WAIT_ON_WARNINGS-} ]  && WAIT_ON_WARNINGS=0
[ -z ${HALT_ON_WARNINGS-} ]  && HALT_ON_WARNINGS=0
DKWARNING_TAG="WARNING: "
##################################################################################
# dk_warning(<message>)
#
#
dk_warning () {
	#dk_verbose "dk_warning($*)"
	[ $# -lt 1 ] && dk_error "dk_verbose($*): requires at least 1 parameter"
	
	warning_msg="$1"
	dk_to_variable_info warning_msg
	dk_echo "${yellow}${DKWARNING_TAG}${warning_msg}${clr}"
	[ $TRACE_ON_WARNINGS = 1 ] && dk_stacktrace
	[ $WAIT_ON_WARNINGS = 1 ] && dk_wait_for_key
	[ $HALT_ON_WARNINGS = 1 ] && exit 1
}