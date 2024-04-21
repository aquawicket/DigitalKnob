# dk_include_guard()

DKINFO_TAG="   INFO: "
##################################################################################
# dk_info(<message>)
#
#
dk_info () {
	#dk_verbose "dk_info($*)"
	[ $# -lt 1 ] && dk_error "dk_info($*): requires at least 1 parameter"
	
	info_msg="$1"
	dk_to_variable_info info_msg
	dk_echo "${white}${DKINFO_TAG}${info_msg}${clr}"
}