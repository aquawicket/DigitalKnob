# dk_includeGuard()

##################################################################################
# dk_pause()
#
#	Pause execution and wait for keypress to continue
#
dk_pause() {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	read -rp 'Press enter to continue...' key
	# echo $key
}