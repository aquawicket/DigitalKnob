#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	
	url="${1}"
	destination="${2-}"
	
	if [ -z "${destination-}" ]; then 
		dk_basename "${url}" DL_FILE
		dk_validate DKDOWNLOAD_DIR "dk_getDKPaths"
		destination="${DKDOWNLOAD_DIR}/${DL_FILE}"
	fi
	
	if dk_pathExists "${destination}"; then
		dk_warning "dk_download(): ${destination} already exists"
		return 0
	fi
	dk_info "Downloading ${url} . . ."
	parentdir="$(dk_dirname "${destination}")"
	dk_printVar parentdir
	OLDPWD=${PWD}
	cd "${parentdir}" #|| dk_error "cd ${parentdir} failed!"
	
	dk_pathExists "${url}" || dk_commandExists "wget" && wget -P "${parentdir}" "${url}"
	dk_pathExists "${url}" || dk_commandExists "curl" && curl -Lo "${destination}" "${url}"
	
	cd "${OLDPWD}" #|| dk_error "cd ${OLDPWD} failed!"
	#[ "${input}" = "" ]
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.sh"
}