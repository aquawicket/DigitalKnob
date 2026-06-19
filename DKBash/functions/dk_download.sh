#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin;
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}";
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}";
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}";
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}";
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}";
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*;
fi
##################################################################################


[ -z "${dk_download_DISABLE_curl-}" ] 		&& export dk_download_DISABLE_curl="0";
[ -z "${dk_download_DISABLE_certutil-}" ] 	&& export dk_download_DISABLE_certutil="0";
[ -z "${dk_download_DISABLE_powershell-}" ] && export dk_download_DISABLE_powershell="0";
[ -z "${dk_download_DISABLE_bitsadmin-}" ] 	&& export dk_download_DISABLE_bitsadmin="1";
[ -z "${dk_download_BACKUP_SERVER-}" ] 		&& export dk_download_BACKUP_SERVER="http://aquawicket.com/DigitalKnob/download";
[ -z "${dk_download_BACKUP_SERVER_TEST-}" ]	&& export dk_download_BACKUP_SERVER_TEST="0";
##################################################################################
# dk_download(url, destination) OVERWRITE
#
#
dk_download() {
# dk_call dk_debug "dk_download($*)";

	dk_debugFunc 1 3;

	url="${1}";
	# dk_call dk_debug "url = ${url}";
	
	dk_call dk_httpStatus ${url};
	dk_call dk_debug "dk_httpStatus = ${dk_httpStatus}";
	if [ ${dk_httpStatus} -gt 299 ] && [ ${dk_httpStatus} -lt 400 ] && [ ${dk_httpStatus} -ne 302 ]; then
		dk_call dk_getUrl ${url} url;
	fi
	
    destination="${2-}";
	# dk_call dk_debug "destination = ${destination}";
	
	[ "${3-}" = "OVERWRITE" ] && OVERWRITE="1" || OVERWRITE="0";
	
	dk_call dk_basename "${url}";
	
#	[ -n "${destination}" ] && dk_call dk_realpath "${destination}" destination;
	# dk_call dk_debug "destination = ${destination}";
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR";
	
	[ -z "${destination}" ] && destination="${DKDOWNLOAD_DIR}/${dk_basename}";
	#dk_call dk_debug "destination = ${destination}";
	
	dk_call dk_isDirectory "${destination}" && destination="${destination}/${dk_basename}";
	#dk_call dk_debug "destination = ${destination}";
	
	if [ -e "${destination}" ]; then
		#if [ "${OVERWRITE}" = "1" ]; then
		#	;#dk_call dk_delete "${destination}";
		#fi
		if [ ! "${OVERWRITE}" = "1" ]; then
			dk_call dk_notice "${dk_basename} file already exists. Use OVERWRITE to re-download existing files.";
			export dk_download="${destination}";
			return $?;
		fi
	fi
	
	if [ "${dk_download_BACKUP_SERVER_TEST}" = "1" ]; then
		url="${dk_download_BACKUP_SERVER}/${dk_basename}";
	fi	
	
	### Test that url exists, if NOT try dk_download_BACKUP_SERVER ###
    dk_call dk_urlExists "${url}" || { 
		dk_call dk_warning "url:${url} NOT FOUND";
		url="${dk_download_BACKUP_SERVER}/${dk_basename}";
		dk_call dk_info "Trying Backup Server url:${url} . . ."; 
	}
    dk_call dk_urlExists "${url}" || dk_call dk_error "url:${url} NOT FOUND";
    dk_call dk_echo "Downloading ${url}";
	
    ### make sure the destination parent directory exists ###
    dk_call dk_dirname "${destination}";
    dk_call dk_mkdir "${dk_dirname}";
	
	export dk_download="${destination}";
	############################### Download ####################################  
	
	### curl
	if [ ! -e "${destination}_DOWNLOADING" ]; then
		if [ ! "${dk_download_DISABLE_curl}" = "1" ]; then
			dk_call dk_debug "Dowloading using curl";
			dk_call dk_validate curl_exe "dk_call dk_depend curl_exe";
			"${curl_exe}" --version 1>/dev/null 2>/dev/null && {
				# 	--time-cond: 	only download if server file newer than local
				#	--remote-time: 	preserve the downloaded files time-stamp
				#	--location: 	follow redirects
				#	--output:		Path to save the file as
				# ${curl_exe} --silent --show-error --head {url} | grep -i Last-Modified
				if [ -e "${destination}" ]; then
					${curl_exe} --silent --show-error --remote-time --location --time-cond "${destination}" --create-dirs --output "${destination}_DOWNLOADING" "${url}";
				else
					${curl_exe} --silent --show-error --remote-time --location --create-dirs --output "${destination}_DOWNLOADING" "${url}";
				fi
				
				[ ! -e "${destination}_DOWNLOADING" ] && return $?;
				
				#dk_call dk_fileSize "${destination}_DOWNLOADING";
				#[ "${dk_fileSize}" = "0" ] && dk_call dk_delete "${destination}_DOWNLOADING";
			}
		fi
	fi	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	# If Dowload Failed
    if [ ! -e "${destination}_DOWNLOADING" ]; then
		dk_call dk_error "url:${url} DOWNLOAD FAILED";
		return $?;	
	fi
	
	# rename temporary download filename to it's original filename
    dk_call dk_rename "${destination}_DOWNLOADING" "${destination}";
    [ ! -e "${destination}" ] && dk_call dk_error "failed to rename ${destination}_DOWNLOADING";
	
	#dk_call dk_log SUCCESS "Download complete";
}
	
#	###### return ######
#	export dk_download="${destination}";
#	builtin echo "${dk_download}";
#	
#	[ -e "${destination}" ] && dk_call dk_info "${destination} already exist" && return;
#	
#	dk_call dk_info "Downloading ${dk_basename}  to  ${destination}";
#	
#	# make sure the destination parent directory exists
#	destination_dir=$(dk_call dk_dirname "${destination}");
#	#dk_call dk_debug "destination_dir = ${destination_dir}";
#	
#	[ -n ${destination_dir} ] || dk_call dk_error "destination_dir is invalid";
#	[ -e ${destination_dir} ] || dk_call dk_mkdir "${destination_dir}";
#	
#	# set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36";
#	
#	# try curl
#	dk_call dk_pathExists "${destination}" || dk_call dk_commandExists "curl" && curl --silent -Lo "${destination}" "${url}" || $(true);
#	
#	# try wget
#	dk_call dk_pathExists "${destination}" || dk_call dk_commandExists "wget" && wget -P "${destination_dir}" "${url}" || $(true);
#	
#	[ -e "${destination}" ] || dk_call dk_error "failed to download ${dk_basename}";








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	#dk_call dk_download "http://aquawicket.com/DigitalKnob/Development/DKBuilder.sh";
	#dk_call dk_download "http://aquawicket.com/Digitalknob/Development/DKBuilder.sh" "DKBuilder.sh";
	#dk_call dk_download "http://aquawicket.com/Digitalknob/Development/DKBuilder.sh" "${DKDOWNLOAD_DIR}/dk_download_batch_test/DKBuilder.sh";
	
	#dk_call dk_download "https://go.microsoft.com/fwlink/?linkid=2289980";
	#dk_call dk_echo "dk_download = ${dk_download}";
	
	DKStorage_DIR="${DIGITALKNOB_DIR}/DKStorage";
	dk_call dk_assertPath "${DKStorage_DIR-}"
	dk_call dk_download "http://aquawicket.com/DigitalKnob/DKStorage/DigitalKnob.bundle" "${DKStorage_DIR}/DigitalKnob.bundle" OVERWRITE;
	dk_call dk_debug "dk_download = ${dk_download}";
}
