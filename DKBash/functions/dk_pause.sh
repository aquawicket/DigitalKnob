# dk_include_guard()

##################################################################################
# dk_pause()
#
#
function dk_pause() {
	dk_debug "dk_pause($@)"
	read -rsp $'Press any key to continue...\n' -n 1 key
	# echo $key
}