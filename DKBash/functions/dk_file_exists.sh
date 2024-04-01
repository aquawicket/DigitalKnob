#include_guard()

##################################################################################
# dk_file_exists()
#
#
dk_file_exists () {
	if [ -z "$1" ]; then
		dk_error "file_exists <file> requires 1 parameter"
		return $false
	fi
	[ -e "$1" ]	
}