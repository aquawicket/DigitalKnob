#include_guard()

##################################################################################
# dk_string_contains()
#
#
dk_string_contains () {
	if [ -z "$2" ]; then
		dk_error "string_contains <string> <substring> requires 2 parameters"
		return $false
	fi
	
	[[ $1 == *"$2"* ]]
}