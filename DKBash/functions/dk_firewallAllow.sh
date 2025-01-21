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
	
	local _file_="$2"
	#local _file_="${_file_:/=\}"
	dk_call dk_assertPath _file_
	
	dk_call dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "${_file_}" && (
		dk_call dk_warning "registry already contains a firewall rule for ${_file_}"
		return 0
	)
	
	dk_call dk_notice "Adding firewall allow rule for ${_file_} . . ."
	
	netsh advfirewall firewall add rule name="$1" dir=in action=allow program="${_file_}" enable=yes profile=any >nul
	netsh advfirewall firewall add rule name="$1" dir=out action=allow program="${_file_}" enable=yes profile=any >nul
	
	###### Windows Firewall Control ######
	[ -e "${WFC_EXE}" ] 	||	local WFC_EXE="C:\Program Files\Malwarebytes\Windows Firewall Control\wfc.exe"
	[ -e "${WFCUI_EXE}" ]	||	local WFCUI_EXE="C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe"
	[ -e "${WFC_EXE}" ]		&&	local WFC_APP="${WFC_EXE}"
	[ -e "${WFCUI_EXE}"	]	&&	local WFC_APP="${WFCUI_EXE}"
	[ -e "${WFC_APP}" ]		&&	local cmnd="${WFC_APP}" -allow "${_file_}"
	[ -e "${CMD_EXE}" ] 	||	local CMD_EXE="${COMSPEC}"
	[ -e "${CMD_EXE}" ]		||	dk_call dk_error "CMD_EXE is invalid"
	echo "cmnd > ${CMD_EXE} /c ${cmnd}"
	${CMD_EXE} /c "${cmnd}"
	######################################
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_firewallAllow "CMake-Gui" "C:/Users/Administrator/digitalknob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake-gui.exe"
}
