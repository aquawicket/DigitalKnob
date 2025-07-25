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


################################################################################
# dk_isChildPathOf(haystack, needle, rtn_var)
#
#   https://en.wikipedia.org/wiki/Dirname
#
dk_isChildPathOf() {
    dk_debugFunc 0 99

	_haystack_="$1"
#	$_haystack_ = $_haystack_ -replace "\\", "/"
#	$_haystack_ = $_haystack_ -replace ":", ""
	dk_call dk_printVar _haystack_
#   if "%_haystack_:~0,1%" equ "\" set "_haystack_=%_haystack_:~1%"		&:: remove first character if it's a '\'

	
	_needle_="$2"
#	$_needle_ = $_needle_ -replace "\\", "/"
#	$_needle_ = $_needle_ -replace ":", ""
	dk_call dk_printVar _needle_
#    if "%_needle_:~0,1%" equ "\" set "_needle_=%_needle_:~1%"
  
	#if [[ ${_haystack_} == *"${_needle_}"* ]]; then 
	if [ "${_haystack_#*"${_needle_}"}" != "${_haystack_}" ]; then
		#if "%~3" neq "" (endlocal & set "%3=true")
		#set "_haystack_="
		#set "_needle_="
		return $(true)
	fi
	
	return $(false)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
DKTEST() {
	dk_debugFunc 0
	
    dk_call dk_echo
    childPath="C:/Program Files/Internet Explorer/en-US"
    parentPath="C:/Program Files"
	if dk_isChildPathOf "$childPath" "$parentPath"; then
		dk_call dk_echo "the path is a child of the parentPath" 
	else
		dk_call dk_echo "the path is NOT a child of the parentPath"
	fi
	
	
	dk_call dk_echo
    childPath="C:/Program Files/Internet Explorer/en-US"
    parentPath="C:/NonExistent"
	if dk_isChildPathOf "$childPath" "$parentPath"; then
		dk_call dk_echo "the path is a child of the parentPath" 
	else
		dk_call dk_echo "the path is NOT a child of the parentPath"
	fi
}
