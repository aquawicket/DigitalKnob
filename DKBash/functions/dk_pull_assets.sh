# dk_include_guard()

##################################################################################
# dk_pull_assets()
#
#
dk_pull_assets () {
	dk_verbose "dk_pull_assets($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_confirm || return 0

	dk_error "not implemented,  TODO"
}