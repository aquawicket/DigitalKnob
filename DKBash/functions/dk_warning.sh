# dk_include_guard()

##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning() {
	#echo "dk_warning($@)"
	#dk_color
	echo -e "${yellow} WARNING: $1 ${clr}"
}