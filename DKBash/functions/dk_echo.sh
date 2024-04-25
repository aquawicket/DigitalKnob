dk_includeGuard

##################################################################################
# dk_echo(<message>)
#
#
dk_echo () {
	#dk_debugFunc

	if [ "$(echo -e)" = "" ]; then
		echo -e "${1-}"
	else
		echo "${1-}"
	fi
}