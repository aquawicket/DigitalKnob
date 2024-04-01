#include_guard()

##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning () {
	if [ -z "$1" ]; then
		dk_error "error <string> requires 1 parameter"
		return $false
	fi
	
	echo -e "${yellow} WARNING: $1 ${CLR}"
}