#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)								&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')								&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# DKINSTALL()
#
#
DKINSTALL() {
	dk_debugFunc 0;
	
	######### kill cmake.exe process #########
	# %dk_call% dk_killProcess cmake.exe

	######### kill cmake-gui.exe process #########
	# %dk_call% dk_killProcess cmake-gui.exe
	
	dk_call dk_getFileParams 		"${CURRENT_IMPORT}/dkconfig.txt"
	dk_call dk_validate Host_Tuple 	"dk_call dk_Host_Tuple"
	# for unknown reasons variable indirection isn't working on WSL here.  aka. ${!variable}
	cmake_Import_="cmake_${Host_Tuple}_Import"
	cmake_Import="${cmake_Import_}"  
	#[ -n "${Linux_X86_64}" ] && cmake_Import="${cmake_Linux_X86_64_Import}"
	dk_call dk_assertVar cmake_Import
	
	if dk_call dk_isUrl "${cmake_Import}"; then
		dk_call dk_info "Installing CMake from direct download"
		
		dk_call dk_basename "${cmake_Import}" cmake_Import_FILE
		dk_call dk_removeExtension "${cmake_Import_FILE}" cmake_Install_Folder
		#dk_call dk_convertToCIdentifier "${cmake_Install_Folder}" cmake_Install_Folder
		dk_call dk_toLower "${cmake_Install_Folder}" cmake_Install_Folder
		
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		[ "${Host_Os}" = "Windows" ]   && export cmake_exe=${DKTOOLS_DIR}/${cmake_Install_Folder}/bin/cmake.exe
		[ "${Host_Os}" = "Mac" ]       && export cmake_exe=${DKTOOLS_DIR}/${cmake_Install_Folder}/CMake.app/Contents/bin/cmake
		[ "${Host_Os}" = "Linux" ]     && export cmake_exe=${DKTOOLS_DIR}/${cmake_Install_Folder}/bin/cmake
		[ "${Host_Os}" = "Raspberry" ] && export cmake_exe=${DKTOOLS_DIR}/${cmake_Install_Folder}/bin/cmake
		[ -z ${cmake_exe} ]            && dk_call dk_error "no cmake for this OS"
		dk_call dk_printVar cmake_exe
		
		dk_call dk_pathExists "${cmake_exe}" && return $(true)

		dk_call dk_echo
		dk_call dk_info "Installing cmake . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download "${cmake_Import}" "${DKDOWNLOAD_DIR}"/"${cmake_Import_FILE}"
		#dk_call dk_extract "${DKDOWNLOAD_DIR}"/"${cmake_Import_FILE}" "${DKTOOLS_DIR}"
		#dk_call dk_removeExtension ${cmake_Import_NAME} cmake_Import_NAME
		#dk_call dk_rename "${DKTOOLS_DIR}/${cmake_Import_NAME}" "${cmake_Install_Folder}"
		#echo ${cmake_Install_Folder}>"${DKTOOLS_DIR}\${cmake_Install_Folder}\installed"
		dk_call dk_smartExtract "${DKDOWNLOAD_DIR}"/"${cmake_Import_FILE}" "${DKTOOLS_DIR}"
		dk_call dk_pathExists "${cmake_exe}" || dk_call dk_error "cannot find cmake.exe"; return -1

	else	# Linux package
		dk_call dk_info "Installing CMake from package managers"
		
		$(command -v cmake) && cmake_exe=$(command -v cmake)
		dk_call dk_realpath ${cmake_exe-} cmake_exe
		dk_call dk_printVar cmake_exe
		if ! dk_call dk_commandExists cmake; then
			dk_call dk_installPackage cmake
		fi	
		cmake_exe=$(command -v cmake)
		dk_call dk_realpath ${cmake_exe} cmake_exe
		dk_call dk_printVar cmake_exe
	fi
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
#	dk_debugFunc 0
	
	DKINSTALL
}