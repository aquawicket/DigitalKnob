# dk_include_guard()

##################################################################################
# dk_file_exists()
#
#
dk_file_exists() {
	dk_debug "dk_file_exists($@)"
	if [ -e "$1" ]; then
		dk_debug "dk_file_exists($@): FOUND"
	else
		dk_warning "dk_file_exists($@): NOT FOUND!" 
	fi
	[ -e "$1" ]
}