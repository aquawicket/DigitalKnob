#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

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
