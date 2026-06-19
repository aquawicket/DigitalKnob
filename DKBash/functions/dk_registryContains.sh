#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


#################################################################################
# dk_registryContains(reg_path, find)
#
#
dk_registryContains() {
	dk_debugFunc 2
 
	dk_call dk_validate reg_exe "dk_call dk_depend reg_exe"
	(command -v "${reg_exe}" 1>/dev/null) || { dk_call dk_error "reg_exe:${reg_exe} failed to run"; return $?; }
	
	while IFS= read -r line; do
		#echo "line = ${line}"
		[ "${line#*"${2}"}" != "${line}" ] && return 0
	done < <(${reg_exe} query ${1})

    return 1
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
   
	local key="HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
	local exe="C:\Windows\System32\curl.exe"
   
    dk_call dk_registryContains "${key}" "${exe}" && (
		dk_call dk_echo "FirewallRules contains ${exe}"
	) || (
		dk_call dk_echo "FirewallRules does NOT contain ${exe}"
	)
}
