#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
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