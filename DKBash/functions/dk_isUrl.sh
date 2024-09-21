#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_isUrl(string)
#
#
dk_isUrl() {
	dk_debugFunc 1

	
	dk_stringContains "${1}" "://" && return $(true)
	return $(false)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	test_url="http://www.aquawicket.com"
	
	if dk_isUrl "${test_url}"; then
		dk_echo "variable is a url"
	else
		dk_echo "variable is NOT a url";
	fi
	
	
	test_not_url="readme.txt"
	if dk_isUrl "${test_not_url}"; then
		dk_echo "variable is a url"
	else
		dk_echo "variable is NOT a url";
	fi
}