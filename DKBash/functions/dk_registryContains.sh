#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


#################################################################################
# dk_registryContains(reg_path, find)
#
#
dk_registryContains() {
	dk_debugFunc 2
 
	export CMD_EXE="/c/Windows/System32/cmd.exe"
	export REG_EXE="C:\Windows\System32\reg.exe"
	
	while IFS= read -r line; do
		#echo "line = ${line}"
		[ "${line#*"${2}"}" != "${line}" ] && return 0
	done < <(${REG_EXE} query $1)

    return 1
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
   
	local key="HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
	local exe="C:\Windows\system32\curl.exe"
   
    dk_call dk_registryContains "${key}" "${exe}" && (
		dk_call dk_echo "FirewallRules contains ${exe}"
	) || (
		dk_call dk_echo "FirewallRules does NOT contain ${exe}"
	)
}
