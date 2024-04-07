# dk_include_guard()

##################################################################################
# dk_error(msg)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
dk_error() {
	#echo "dk_error($@)"
	echo -e "${red} ERROR: $1 ${clr}"
	dk_stacktrace
	if [ $HALT_ON_ERRORS == 1 ]; then
		exit 1
	fi
}