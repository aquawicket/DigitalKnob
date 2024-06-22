#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

###### fallback functions ######
$(command -v dk_pathExists 1>nul 2>&1) || function dk_pathExists(){ [ -e "$1" ]; }
$(command -v dk_error 1>nul 2>&1)      || function dk_error(){ echo "ERROR: $1"; }
$(command -v dk_warning 1>nul 2>&1)    || function dk_warning(){ echo "WARNING: $1"; }
$(command -v dk_info 1>nul 2>&1)       || function dk_info(){ echo "$1"; }
$(command -v dk_printVar 1>nul 2>&1)   || function dk_printVar(){ echo "$1 = ${!1}"; }
##################################################################################
# dk_download(<url> <destination>)
#
#
dk_download (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	if dk_pathExists "$2"; then
		dk_warning "dk_download(): $2 already exists"
		return 0
	fi
	dk_info "Downloading $1 . . ."
	parentdir="$(dirname "$2")"
	dk_printVar parentdir
	OLDPWD=${PWD}
	cd "${parentdir}" #|| dk_error "cd ${parentdir} failed!"
	
	dk_pathExists "$1" || [ -n "$(command -v "curl")" ] && curl -Lo "$2" "$1"
	dk_pathExists "$1" || [ -n "$(command -v "wget")" ] && wget -P "${parentdir}" "$1"

	cd "${OLDPWD}" #|| dk_error "cd ${OLDPWD} failed!"
	#[ "${input}" = "" ]
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.sh" C:/DKBuilder.sh
}