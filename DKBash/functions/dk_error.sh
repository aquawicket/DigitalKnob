# dk_include_guard()


[ -z ${TRACE_ON_ERRORS-} ]    && TRACE_ON_ERRORS=1
[ -z ${PAUSE_ON_ERRORS-} ]     && PAUSE_ON_ERRORS=1
[ -z ${CONTINUE_ON_ERRORS-} ] && CONTINUE_ON_ERRORS=0
DKERROR_TAG="  ERROR: "
##################################################################################
# dk_error(<message>)
#
#
dk_error () {
	#dk_verbose "dk_error($*)"
	[ $# -lt 1 ] && dk_echo "dk_verbose($*): requires at least 1 parameter"
	
	error_msg="$1"
	dk_to_variable_info error_msg
	dk_echo "${red}${DKERROR_TAG}${error_msg}${clr}"
	[ $TRACE_ON_ERRORS = 1 ]    && dk_stacktrace
	[ $PAUSE_ON_ERRORS = 1 ]    && dk_pause
	[ $CONTINUE_ON_ERRORS = 1 ] && return 0
	exit 1
}