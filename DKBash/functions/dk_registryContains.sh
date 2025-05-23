#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

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
