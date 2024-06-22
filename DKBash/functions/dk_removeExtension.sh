#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_removeExtension(<filepath> <output>)
#
#
dk_removeExtension (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	_filepath_="$1"
	_filepath_="${_filepath_%.*}"									    # remove everything past last dot
	[ "${_filepath_##*.}" = "tar" ] &&	_filepath_="${_filepath_%.*}"	# if .tar remove everything past last dot
	eval "$2='${_filepath_}'"
	dk_printVar $2
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	filepath="/test/test2/xfile.extension"
	dk_removeExtension "${filepath}" name
	echo "name = ${name}"
}