#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
	dk_debugFunc 1 2

	url="${1}"
	dk_call dk_debug "url = ${url}"
	
	dk_call dk_httpResponse ${url}
	if [ ${dk_httpResponse} -gt 299 ] && [ ${dk_httpResponse} -lt 400 ]; then
		dk_call dk_getUrl ${url} url
	fi
	
    destination="${2-}"
	dk_call dk_debug "destination = ${destination}"
	
	url_filename=$(dk_call dk_basename ${url})

	dk_call dk_debug "destination = ${destination}"
	[ -z "${url_filename-}" ] && dk_call dk_error "url_filename invalid"
	
#	[ -n ${destination} ] && dk_call dk_realpath "${destination}" destination
#	dk_call dk_debug "destination = ${destination}"
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	
	[ -z ${destination} ] && destination="${DKDOWNLOAD_DIR}/${url_filename}"
	#dk_call dk_debug "destination = ${destination}"
	
	[ -z ${destination} ] && dk_call dk_error "destination is invalid"
	#dk_call dk_debug "destination = ${destination}"
	
	dk_call dk_isDirectory "${destination}" && destination="${destination}/${url_filename}"
	#dk_call dk_debug "destination = ${destination}"
	
	###### output ######
	export dk_download="${destination}";
	builtin echo "${dk_download}";
	
	[ -e "${destination}" ] && dk_call dk_info "${destination} already exist" && return
	
	dk_call dk_info "Downloading ${url_filename}  to  ${destination}"
	
	# make sure the destination parent directory exists
	destination_dir=$(dk_call dk_dirname "${destination}")
	#dk_call dk_debug "destination_dir = ${destination_dir}"
	
	[ -n ${destination_dir} ] || dk_call dk_error "destination_dir is invalid"
	[ -e ${destination_dir} ] || dk_call dk_mkdir "${destination_dir}"
	
	# set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
	
	# try curl
	dk_call dk_pathExists "${destination}" || dk_call dk_commandExists "curl" && curl --silent -Lo "${destination}" "${url}" || $(true)
	
	# try wget
	dk_call dk_pathExists "${destination}" || dk_call dk_commandExists "wget" && wget -P "${destination_dir}" "${url}" || $(true)
	
	[ -e "${destination}" ] || dk_call dk_error "failed to download ${url_filename}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#dk_call dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.sh"
	#dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.sh" "DKBuilder.sh"
	#dk_call dk_download "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.sh" "${DKDOWNLOAD_DIR}/dk_download_batch_test/DKBuilder.sh"
	
	dk_call dk_download "https://go.microsoft.com/fwlink/?linkid=2289980"
	dk_call dk_echo "dk_download = ${dk_download}"
}
