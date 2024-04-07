# dk_include_guard()

##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function dk_debug() {
	#echo "dk_debug($@)"
	if [ $LOG_DEBUG == 1 ]; then 
		dk_load dk_color
		echo -e "${blue} DEBUG: $1 ${clr}"
	fi
}