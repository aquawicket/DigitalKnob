# dk_include_guard()

##################################################################################
# dk_get_filename(<path> <output>)
#
#
dk_get_filename() {
	dk_debug "dk_get_filename($@)"
	if [ -z "$2" ]; then
		dk_error "dk_get_filename <path> <output> requires 2 parameters"
		return "$false"
	fi
	
	eval "$2=$(basename $1)"
	#[[ $base_name == "" ]]
}