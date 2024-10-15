#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
	dk_debugFunc 1 2

	url="${1}"
	dk_call dk_printVar url
	
    destination="${2-}"
    #dk_call dk_printVar destination
	
	#dk_call dk_echo "dk_basename "${url}" url_filename"
	
	url_filename=$(dk_call dk_basename ${url})

	dk_call dk_printVar url_filename
	[ -z "${url_filename-}" ] && dk_call dk_error "url_filename invalid"
	
#	[ -n ${destination} ] && dk_call dk_realpath "${destination}" destination
#	dk_call dk_printVar destination
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DIGITALKNOB_DIR"
	
	[ -z ${destination} ] && destination="${DKDOWNLOAD_DIR}/${url_filename}"
	#dk_call dk_printVar destination
	
	[ -z ${destination} ] && dk_call dk_error "destination is invalid"
	#dk_call dk_printVar destination
	
	dk_call dk_isDirectory "${destination}" && destination="${destination}/${url_filename}"
	#dk_call dk_printVar destination
	
	[ -e "${destination}" ] && dk_call dk_info "${destination} already exist" && return
	
	dk_call dk_info "Downloading ${url_filename}  to  ${destination}"
	
	# make sure the destination parent directory exists
	destination_dir=$(dk_call dk_dirname "${destination}")
	#dk_call dk_printVar destination_dir
	
	[ -n ${destination_dir} ] || dk_call dk_error "destination_dir is invalid"
	[ -e ${destination_dir} ] || dk_call dk_makeDirectory "${destination_dir}"
	
	# set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
	
	# try wget
	dk_call dk_pathExists "${destination}" || dk_call dk_commandExists "wget" && wget -P "${destination_dir}" "${url}" || $(true)
	
	# try curl
	dk_call dk_pathExists "${destination}" || dk_call dk_commandExists "curl" && curl --silent -Lo "${destination}" "${url}" || $(true)
	
	
	[ -e "${destination}" ] || dk_call dk_error "failed to download ${url_filename}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#dk_call dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.sh"
	#dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.sh" "DKBuilder.sh"
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.sh" "${DKDOWNLOAD_DIR}/dk_download_batch_test/DKBuilder.sh"
}
