#!/bin/sh
[ -z "${DKINIT}" ] && . ../../../DKBash/functions/DK.sh

# https://github.com/PowerShell/PowerShell/releases
PWSH_DL_LINUX_ARM32=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm32.tar.gz
PWSH_DL_LINUX_ARM64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm64.tar.gz
PWSH_DL_LINUX_x86_64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-x64.tar.gz
PWSH_DL_OSX_ARM64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-arm64.tar.gz
PWSH_DL_OSX_X86_64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-x64.tar.gz
PWSH_DL_WIN_ARM32=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm32.zip
PWSH_DL_WIN_ARM64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm64.zip
PWSH_DL_WIN_x86=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x86.zip
PWSH_DL_WIN_x86_64=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x64.zip


##################################################################################
# dk_installPwsh()
#
#
dk_installPwsh() {
	dk_debugFunc 0

	
	dk_validate HOST_OS "dk_getHostTriple"
	######################################################################################################
	[ "${HOST_OS}_${HOST_ARCH}" = "linux_arm32" ]	&& PWSH_DL=${PWSH_DL_LINUX_ARM32}
	[ "${HOST_OS}_${HOST_ARCH}" = "linux_arm64" ]	&& PWSH_DL=${PWSH_DL_LINUX_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "linux_x86_64" ]	&& PWSH_DL=${PWSH_DL_LINUX_x86_64}
	[ "${HOST_OS}_${HOST_ARCH}" = "mac_arm64" ]		&& PWSH_DL=${PWSH_DL_OSX_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "mac_x86_64" ]	&& PWSH_DL=${PWSH_DL_OSX_X86_64}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_arm32" ]		&& PWSH_DL=${PWSH_DL_WIN_ARM32}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_arm64" ]		&& PWSH_DL=${PWSH_DL_WIN_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86" ]		&& PWSH_DL=${PWSH_DL_WIN_x86}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86_64" ]	&& PWSH_DL=${PWSH_DL_WIN_x86_64}
	
	[ -z "${PWSH_DL}" ] && dk_error "PWSH_DL is invalid"
	dk_printVar PWSH_DL
	
	dk_basename "${PWSH_DL}" PWSH_DL_FILE
	dk_removeExtension "${PWSH_DL_FILE}" PWSH_FOLDER
	#dk_convertToCIdentifier "${PWSH_FOLDER}" PWSH_FOLDER
	dk_toLower "${PWSH_FOLDER}" PWSH_FOLDER
	dk_validate DKTOOLS_DIR "dk_getDKPaths"
	PWSH=${DKTOOLS_DIR}/${PWSH_FOLDER}
	
	[ "${HOST_OS}" = "win" ]       && PWSH_EXE=${PWSH}/pwsh.exe
	[ "${HOST_OS}" = "mac" ]       && PWSH_EXE=${PWSH}/pwsh.app/Contents/bin/pwsh
	[ "${HOST_OS}" = "linux" ]     && PWSH_EXE=${PWSH}/pwsh
	[ "${HOST_OS}" = "raspberry" ] && PWSH_EXE=${PWSH}/pwsh
	dk_printVar PWSH_EXE
		
	if dk_pathExists "${PWSH_EXE}"; then 
		return $(true);
	fi
	
	dk_echo
	dk_info "Installing Pwsh . . ."
	dk_download "${PWSH_DL}" "${DKDOWNLOAD_DIR}/${PWSH_DL_FILE}"
	dk_smartExtract "${DKDOWNLOAD_DIR}/${PWSH_DL_FILE}" "${PWSH}"
}
dk_installPwsh
exit
exit
exit


	