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


###############################################################################
# dk_firewallAllow(executable)
# dk_firewallAllow(name executable)
#
#	@name:optional 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
dk_firewallAllow() {
	dk_debugFunc 1 2
	
	[ -n "${2-}" ] && (_name_=${1}; _file_=${2}) || _file_=${1};
	
	### _name_ ###
	[ -z "${_name_-}"] && _name_=$(dk_call dk_basename ${_file_});
	dk_call dk_assertVar _name_;
	
	### _file_ ###
	local _file_="${_file_////\\}"	# get path with / converted to \
	dk_call dk_debug "_file_ = ${_file_}";
	
	dk_call dk_assertVar _name_;
	dk_call dk_assertVar _file_;
	
	local key="HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
	
	dk_call dk_registryContains "${key}" "${_file_}" && {
		dk_call dk_notice "registry already contains a firewall rule for '${_file_}'"
		return $?
	}

	dk_call dk_notice "Adding firewall allow rule for ${_file_} . . ."
	
	###### netsh_exe ######
	[ ! -e "${netsh_exe-}" ] && export netsh_exe="C:\Windows\System32\netsh.exe"
	[ ! -e "${netsh_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && export netsh_exe=$(cygpath -u ${netsh_exe})
	[ ! -e "${netsh_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && export netsh_exe=$(wslpath -u ${netsh_exe})
	  [ -e "${netsh_exe-}" ] && ${netsh_exe} advfirewall firewall add rule name="${_name_}" dir=in action=allow program="${_file_}" enable=yes profile=any 1>/dev/null
	  [ -e "${netsh_exe-}" ] && ${netsh_exe} advfirewall firewall add rule name="${_name_}" dir=out action=allow program="${_file_}" enable=yes profile=any 1>/dev/null
	
	###### Windows Firewall Control ######
	[ ! -e "${wfc_exe-}" ] && export wfc_exe="C:\Program Files\Malwarebytes\Windows Firewall Control\wfc.exe"
	[ ! -e "${wfc_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && export wfc_exe=$(cygpath -u "${wfc_exe-}");
	[ ! -e "${wfc_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && export wfc_exe=$(wslpath -u "${wfc_exe-}");
	[ ! -e "${wfc_exe-}" ] && export wfc_exe="C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe"
	[ ! -e "${wfc_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && export wfc_exe=$(cygpath -u "${wfc_exe-}");
	[ ! -e "${wfc_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && export wfc_exe=$(wslpath -u "${wfc_exe-}");
	  [ -e "${wfc_exe-}" ] && "${wfc_exe}" -allow "${_file_}" & return 0
	######################################
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#dk_call dk_firewallAllow "Notepad" "C:/Windows/notepad.exe"
	dk_call dk_firewallAllow "C:/Windows/notepad.exe"
}
