#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_urlExists(url)
#
#
dk_urlExists() {
	dk_debugFunc 1

	if curl --head --silent --fail $1 1> /dev/null 2>1; then
		return $(true)
	fi
	
	return $(false)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	if dk_urlExists "http://www.google.com/index.html"; then
		echo "The url exists"
	else
		echo "The url does NOT exist"
	fi
	
	if dk_urlExists "http://www.nonexisting.com/nofile.no"; then
		echo "The url exists"
	else
		echo "The url does NOT exist"
	fi
}