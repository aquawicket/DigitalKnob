# dk_include_guard()

##################################################################################
# dk_wait_for_key()
#
#
dk_wait_for_key () {
	dk_verbose "dk_wait_for_key($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	read -rp 'Press enter to continue...' key
}