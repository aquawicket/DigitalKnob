# dk_include_guard()

##################################################################################
# dk_echo(<message>)
#
#
dk_echo () {
	#echo "dk_echo($*)"

	if [ "$(echo -e)" = "" ]; then
		echo -e "$1"
	else
		echo "$1"
	fi
}