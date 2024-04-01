#include_guard()

LOG_DEBUG=1
##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug () {
	#echo "dk_debug($@)"
	if [ $LOG_DEBUG ]; then 
		#$echo ${blue}DEBUG: $1 ${clr}
		$echo ${blue}$1 ${clr}
		return 0 #true
	fi
}