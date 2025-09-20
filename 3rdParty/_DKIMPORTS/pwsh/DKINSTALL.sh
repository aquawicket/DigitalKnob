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

# https://github.com/PowerShell/PowerShell/releases
pwsh_Linux_Arm32_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm32.tar.gz
pwsh_Linux_Arm64_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm64.tar.gz
pwsh_Linux_X86_64_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-x64.tar.gz
pwsh_Mac_Arm64_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-arm64.tar.gz
pwsh_Mac_X86_64_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-x64.tar.gz
pwsh_Windows_Arm32_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm32.zip
pwsh_Windows_Arm64_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm64.zip
pwsh_Windows_X86_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x86.zip
pwsh_Windows_X86_64_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x64.zip


##################################################################################
# DKINSTALL()
#
#
DKINSTALL() {
	dk_debugFunc 0

	
	dk_validate Host_Tuple "dk_Host_Tuple"
	######################################################################################################
	[ "${Host_Os}_${Host_Arch}" = "Linux_Arm32_Host" ]		&& pwsh_Import=${pwsh_Linux_Arm32}
	[ "${Host_Os}_${Host_Arch}" = "Linux_Arm64_Host" ]		&& pwsh_Import=${pwsh_Linux_Arm64}
	[ "${Host_Os}_${Host_Arch}" = "Linux_X86_64_Host" ]		&& pwsh_Import=${pwsh_Linux_X86_64}
	[ "${Host_Os}_${Host_Arch}" = "Mac_Arm64_Host" ]		&& pwsh_Import=${pwsh_Mac_Arm64}
	[ "${Host_Os}_${Host_Arch}" = "Mac_X86_64_Host" ]		&& pwsh_Import=${pwsh_Mac_X86_64}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm32_Host" ]	&& pwsh_Import=${pwsh_Windows_Arm32}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm64_Host" ]	&& pwsh_Import=${pwsh_Windows_Arm64}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86_Host" ]		&& pwsh_Import=${pwsh_Windows_X86}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86_64_Host" ]	&& pwsh_Import=${pwsh_Windows_X86_64}
	
	[ -z "${pwsh_Import}" ] && dk_error "pwsh_Import is invalid"
	dk_printVar pwsh_Import
	
	dk_basename "${pwsh_Import}" pwsh_Import_File
	dk_removeExtension "${pwsh_Import_File}" pwsh_Import_Name
	dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	PWSH=${DKTOOLS_DIR}/${pwsh_Import_Name}
	
	[ "${Host_Os}" = "Windows" ]	&& pwsh_exe=${PWSH}/pwsh.exe
	[ "${Host_Os}" = "Mac" ]		&& pwsh_exe=${PWSH}/pwsh.app/Contents/bin/pwsh
	[ "${Host_Os}" = "Linux" ]		&& pwsh_exe=${PWSH}/pwsh
	[ "${Host_Os}" = "Raspberry" ]	&& pwsh_exe=${PWSH}/pwsh
	dk_printVar pwsh_exe
		
	if dk_pathExists "${pwsh_exe}"; then 
		return $(true);
	fi
	
	dk_echo
	dk_info "Installing Pwsh . . ."
	dk_download "${pwsh_Import}"
	dk_smartExtract "${dk_download}" "${PWSH}"
}
DKINSTALL
exit
exit
exit


	