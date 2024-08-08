#!/bin/sh
[ -z "${DKINIT}" ] && . ../../../DKBash/functions/DK.sh

# https://github.com/PowerShell/PowerShell/releases
POWERSHELL_DL_LINUX_ARM32=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm32.tar.gz
POWERSHELL_DL_LINUX_ARM64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm64.tar.gz
POWERSHELL_DL_LINUX_x86_64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-x64.tar.gz
POWERSHELL_DL_OSX_ARM64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-arm64.tar.gz
POWERSHELL_DL_OSX_X86_64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-x64.tar.gz
POWERSHELL_DL_WIN_ARM32=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm32.zip
POWERSHELL_DL_WIN_ARM64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm64.zip
POWERSHELL_DL_WIN_x86=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x86.zip
POWERSHELL_DL_WIN_x86_64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x64.zip


##################################################################################
# dk_installPowershell()
#
#
dk_installPowershell() {
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_validate HOST_OS "dk_getHostTriple"
	######################################################################################################
	[ "${HOST_OS}_${HOST_ARCH}" = "linux_arm32" ]	&& POWERSHELL_DL=${POWERSHELL_DL_LINUX_ARM32}
	[ "${HOST_OS}_${HOST_ARCH}" = "linux_arm64" ]	&& POWERSHELL_DL=${POWERSHELL_DL_LINUX_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "linux_x86_64" ]	&& POWERSHELL_DL=${POWERSHELL_DL_LINUX_x86_64}
	[ "${HOST_OS}_${HOST_ARCH}" = "mac_arm64" ]		&& POWERSHELL_DL=${POWERSHELL_DL_OSX_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "mac_x86_64" ]	&& POWERSHELL_DL=${POWERSHELL_DL_OSX_X86_64}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_arm32" ]		&& POWERSHELL_DL=${POWERSHELL_DL_WIN_ARM32}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_arm64" ]		&& POWERSHELL_DL=${POWERSHELL_DL_WIN_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86" ]		&& POWERSHELL_DL=${POWERSHELL_DL_WIN_x86}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86_64" ]	&& POWERSHELL_DL=${POWERSHELL_DL_WIN_x86_64}
	
	[ -z "${POWERSHELL_DL}" ] && dk_error "POWERSHELL_DL is invalid"
	dk_printVar POWERSHELL_DL
	
	dk_basename "${POWERSHELL_DL}" POWERSHELL_DL_FILE
	dk_removeExtension "${POWERSHELL_DL_FILE}" POWERSHELL_FOLDER
	dk_convertToCIdentifier "${POWERSHELL_FOLDER}" POWERSHELL_FOLDER
	dk_toLower "${POWERSHELL_FOLDER}" POWERSHELL_FOLDER
	dk_validate DKTOOLS_DIR "dk_getDKPaths"
	POWERSHELL=${DKTOOLS_DIR}/${POWERSHELL_FOLDER}
	
	[ "${HOST_OS}" = "win" ]       && POWERSHELL_EXE=${POWERSHELL}/pwsh.exe
	[ "${HOST_OS}" = "mac" ]       && POWERSHELL_EXE=${POWERSHELL}/powershell.app/Contents/bin/pwsh
	[ "${HOST_OS}" = "linux" ]     && POWERSHELL_EXE=${POWERSHELL}/pwsh
	[ "${HOST_OS}" = "raspberry" ] && POWERSHELL_EXE=${POWERSHELL}/pwsh
	dk_printVar POWERSHELL_EXE
		
	if dk_pathExists "${POWERSHELL_EXE}"; then 
		return ${true};
	fi
	
	dk_echo
	dk_info "Installing Powershell . . ."
	dk_download "${POWERSHELL_DL}" "${DKDOWNLOAD_DIR}/${POWERSHELL_DL_FILE}"
	dk_smartExtract "${DKDOWNLOAD_DIR}/${POWERSHELL_DL_FILE}" "${POWERSHELL}"
}
dk_installPowershell
exit
exit
exit


	