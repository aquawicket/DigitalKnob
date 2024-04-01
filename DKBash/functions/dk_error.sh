#include_guard()

##################################################################################
# dk_error(msg)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
dk_error () {
	if [ -z "$1" ]; then
		echo -e "error <string> requires 1 parameter"
		return $false
	fi
	
	echo -e "${red} ERROR: $1 ${CLR}"
}