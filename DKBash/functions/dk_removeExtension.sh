#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_removeExtension(<filepath> <output>)
#
#
dk_removeExtension() {
	dk_debugFunc 1 2

	
	_filepath_="${1}"
	_filepath_="${_filepath_%.*}"									    # remove everything past last dot
	[ "${_filepath_##*.}" = "tar" ] &&	_filepath_="${_filepath_%.*}"	# if .tar remove everything past last dot

	### return value ###
	dk_call dk_printVar _filepath_
	[ ${#} -gt 1 ] && eval "${2}=${_filepath_}" && return  # return value when using rtn_var parameter 
	dk_return ${_filepath_}; return						  # return value when using command substitution 
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	filepath="/test/test2/xfile.extension"
	dk_removeExtension "${filepath}" name
	echo "name = ${name}"
}