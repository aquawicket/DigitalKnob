#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_download(<url> <destination>)
#
#
dk_download () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	if dk_fileExists "$2"; then
		dk_warning "dk_download(): $2 already exists"
		return 0
	fi
	dk_info "Downloading $1 . . ."
	parentdir="$(dirname "$2")"
	dk_printVar parentdir
	OLDPWD=${PWD}
	cd "${parentdir}" #|| dk_error "cd ${parentdir} failed!"
	if dk_commandExists "wget"; then
		wget -P "${parentdir}" "$1"
	elif dk_commandExists "curl"; then
		curl -Lo "$2" "$1"
	else
		dk_error "dk_download(): could not find wget or curl"
	fi
	cd "${OLDPWD}" #|| dk_error "cd ${OLDPWD} failed!"
	#[ "${input}" = "" ]
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.sh" C:/DKBuilder.sh
}