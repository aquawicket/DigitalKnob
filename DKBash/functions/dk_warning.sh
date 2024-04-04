#include_guard()

##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function dk_warning() {
	#echo "dk_warning($@)"
	echo -e "${yellow} WARNING: $1 ${CLR}"
}