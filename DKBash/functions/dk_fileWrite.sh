#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_fileWrite(<file> <string>)
#
#
dk_fileWrite (){
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	echo ${2} > ${1} 
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc

	dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
}