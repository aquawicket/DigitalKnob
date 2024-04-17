# dk_include_guard()

##################################################################################
# dk_echo(<message>)
#
#    Print a message to the console
#
#    <msg> - The message to print
#
dk_echo () {
	#echo "dk_echo($*)"

	if [ "$(echo -e)" = "" ]; then
		echo -e "${1-}"
	else
		echo "${1-}"
	fi
}