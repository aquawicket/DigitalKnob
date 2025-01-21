#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

###############################################################################
# dk_firewallAllow(name executable)
#
#	  @name		 	- The name of the firewall rule
#   @executable	- The path to the executable to allow
#
dk_firewallAllow() {
	dk_debugFunc 2
	
	local _file_="${2////\\}"	# get path with / converted to \
	dk_call dk_assertPath _file_
	
	dk_call dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "${_file_}" && (
		dk_call dk_warning "registry already contains a firewall rule for ${_file_}"
		return 0
	)
	
	dk_call dk_notice "Adding firewall allow rule for ${_file_} . . ."
	
	netsh advfirewall firewall add rule name="$1" dir=in action=allow program="${_file_}" enable=yes profile=any >nul
	netsh advfirewall firewall add rule name="$1" dir=out action=allow program="${_file_}" enable=yes profile=any >nul
	
	###### Windows Firewall Control ######
	[ -e "${WFC_EXE-}" ] 	||	local WFC_EXE="C:\Program Files\Malwarebytes\Windows Firewall Control\wfc.exe"
	[ -e "${WFCUI_EXE-}" ]	||	local WFCUI_EXE="C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe"
	[ -e "${WFC_EXE-}" ]	&&	local WFC_APP="${WFC_EXE}"
	[ -e "${WFCUI_EXE-}" ]	&&	local WFC_APP="${WFCUI_EXE}"
	"${WFC_APP}" -allow "${_file_}"
	######################################
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_firewallAllow "Notepad" "C:/Windows/notepad.exe"
}
