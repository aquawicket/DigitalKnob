#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh

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
# DKINSTALL()
#
#
DKINSTALL() {
	dk_debugFunc 0

	
	dk_validate Host_Tuple "dk_Host_Tuple"
	######################################################################################################
	[ "${Host_Os}_${Host_Arch}" = "Linux_Arm32" ]	&& PWSH_DL=${PWSH_DL_LINUX_ARM32}
	[ "${Host_Os}_${Host_Arch}" = "Linux_Arm64" ]	&& PWSH_DL=${PWSH_DL_LINUX_ARM64}
	[ "${Host_Os}_${Host_Arch}" = "Linux_X86_64" ]	&& PWSH_DL=${PWSH_DL_LINUX_x86_64}
	[ "${Host_Os}_${Host_Arch}" = "Mac_Arm64" ]		&& PWSH_DL=${PWSH_DL_OSX_ARM64}
	[ "${Host_Os}_${Host_Arch}" = "Mac_X86_64" ]	&& PWSH_DL=${PWSH_DL_OSX_X86_64}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm32" ]		&& PWSH_DL=${PWSH_DL_WIN_ARM32}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm64" ]		&& PWSH_DL=${PWSH_DL_WIN_ARM64}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86" ]		&& PWSH_DL=${PWSH_DL_WIN_x86}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86_64" ]	&& PWSH_DL=${PWSH_DL_WIN_x86_64}
	
	[ -z "${PWSH_DL}" ] && dk_error "PWSH_DL is invalid"
	dk_printVar PWSH_DL
	
	dk_basename "${PWSH_DL}" PWSH_DL_FILE
	dk_removeExtension "${PWSH_DL_FILE}" PWSH_FOLDER
	#dk_convertToCIdentifier "${PWSH_FOLDER}" PWSH_FOLDER
	dk_toLower "${PWSH_FOLDER}" PWSH_FOLDER
	dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	PWSH=${DKTOOLS_DIR}/${PWSH_FOLDER}
	
	[ "${Host_Os}" = "Windows" ]	&& PWSH_EXE=${PWSH}/pwsh.exe
	[ "${Host_Os}" = "Mac" ]		&& PWSH_EXE=${PWSH}/pwsh.app/Contents/bin/pwsh
	[ "${Host_Os}" = "Linux" ]		&& PWSH_EXE=${PWSH}/pwsh
	[ "${Host_Os}" = "Raspberry" ]	&& PWSH_EXE=${PWSH}/pwsh
	dk_printVar PWSH_EXE
		
	if dk_pathExists "${PWSH_EXE}"; then 
		return $(true);
	fi
	
	dk_echo
	dk_info "Installing Pwsh . . ."
	dk_download "${PWSH_DL}" "${DKDOWNLOAD_DIR}/${PWSH_DL_FILE}"
	dk_smartExtract "${DKDOWNLOAD_DIR}/${PWSH_DL_FILE}" "${PWSH}"
}
DKINSTALL
exit
exit
exit


	