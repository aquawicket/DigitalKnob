#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_isUrl(string)
#
#
dk_isUrl() {
	dk_debugFunc 1

	
	dk_call dk_contains "${1}" "://" && return $(true)
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