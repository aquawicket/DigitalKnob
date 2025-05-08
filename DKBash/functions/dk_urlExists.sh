#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_urlExists(url)
#
#
dk_urlExists() {
	dk_debugFunc 1

	dk_call dk_httpResponse ${1}
	
	#echo dk_httpResponse = %dk_httpResponse%

	if [ ${dk_httpResponse} -eq 200 ]; then
		dk_urlExists=0
	elif [ ${dk_httpResponse} -eq 301 ]; then
		dk_urlExists=0
	elif [ ${dk_httpResponse} -eq 302 ]; then
		dk_urlExists=0
	else
		dk_urlExists=1
	fi
	

	export dk_urlExists=${dk_urlExists}
	#if ["$2" -ne "" ]; then "$2=${dk_urlExists}"
	
	dk_call dk_echo "dk_urlExists = ${dk_urlExists}"
	return ${dk_urlExists}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	###### Using if return value
	dk_call dk_echo
	url="http://www.google.com/index.html"
	dk_call dk_urlExists ${url}
	[ ${dk_urlExists} -eq 0 ] && dk_call dk_echo "${url} exists" || dk_call dk_echo "${url} does NOT exist"
	dk_call dk_echo "dk_urlExists = ${dk_urlExists}"
	
	dk_call dk_echo
	url="http://www.nonexisting.com/nofile.no"
	dk_call dk_urlExists "${url}"
	[ ${dk_urlExists} -eq 0 ] && dk_call dk_echo "${url%} exists" || dk_call dk_echo "${url} does NOT exist"
	dk_call dk_echo "dk_urlExists = ${dk_urlExists}"
	#FIXME: ERRORLEVEL is still 1 
	
	
	
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