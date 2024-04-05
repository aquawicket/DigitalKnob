# dk_include_guard()

##################################################################################
# dk_rename()
#
#
function dk_rename() {
	dk_debug "rename($@)"
	if [ -z "$2" ]; then
		dk_error "dk_get_filename <path> <output> requires 2 parameters"
		return $false
	fi
	
	#TODO
	#[[ ? == "success" ]]
}