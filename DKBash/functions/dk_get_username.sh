# dk_include_guard()

##################################################################################
# dk_get_username()
#
#
dk_get_username () {
	dk_verbose "dk_build_main($*)"
	
	if [ -n "${USER-}" ]; then
		dk_debug USER
		DKUSERNAME=$USER
	elif [ -n "${USERNAME-}" ]; then
		dk_debug USERNAME
		DKUSERNAME=$USERNAME
	fi
	dk_debug DKUSERNAME
}