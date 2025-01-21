#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

#################################################################################
# dk_registryContains(reg_path, find)
#
#
dk_registryContains() {
	dk_debugFunc 2
 
#	for /f "usebackq delims=" %%a in (`reg query $1`) do (
#		local "str=%%a"
#		
#		if not "x!str:%~2=!x" == "x!str!x" (
#			return 0
#		)
#	)
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
	local exe="C:\Windows\notepad.exe"
   
    dk_call dk_registryContains "${key}" "${exe}" && (
		dk_call dk_echo "FirewallRules contains ${exe}"
	) || (
		dk_call dk_echo "FirewallRules does NOT contain ${exe}"
	)
}
