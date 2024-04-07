# dk_include_guard()
echo "dk_echo.sh:2 ENTER"
##################################################################################
# dk_echo(msg)
#
#	Print a message to the console
#
#	@msg	- The message to print
#
dk_echo () {
	#echo "dk_echo($@)"
	echo -e "$@"
}
echo "dk_echo.sh:2 EXIT"