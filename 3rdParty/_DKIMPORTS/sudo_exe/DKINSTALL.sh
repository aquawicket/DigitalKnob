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


dk_set(DKSudo_pass "2393")
##################################################################################
# DKINSTALL
#
DKINSTALL() {
	dk_debugFunc 0;
	
	### builtin_exe
	(command -v "builtin" >/dev/null 2>&1) && export builtin_exe=$(command -v "builtin");
	
	### sudo_exe
	if [ ! -e "${sudo-}" ]; then
		[ ! -e "${sudo-}" ] && [ -e "/usr/bin/sudo" ]					&& export sudo="/usr/bin/sudo";
		[ ! -e "${sudo-}" ] && [ -e "C:/Windows/System32/sudo.exe" ]	&& export sudo="C:/Windows/System32/sudo.exe";
		[ ! -e "${sudo-}" ] && [ command -v 'cygpath' >/dev/null 2>&1 ]	&& export sudo=$(cygpath -u "${sudo}");
		[ ! -e "${sudo-}" ] && [ command -v 'wslpath' >/dev/null 2>&1 ]	&& export sudo=$(wslpath -u "${sudo}");
		[ ! -e "${sudo-}" ] && [ ! command -v "sudo" >/dev/null 2>&1 ] 	&& dk_call dk_installPackage sudo;
		[ ! -e "${sudo-}" ] && [ command -v "sudo" >/dev/null 2>&1 ]	&& export sudo=$(command -v "sudo");
		dk_call dk_assertPath ${sudo};
		( "${sudo-}" --version >/dev/null 2>&1 ) || { dk_call dk_error "sudo:${sudo-} failed to run"; return $?; } # Test Execute
		dk_call dk_debug "sudo = ${sudo}";
	fi
	
	### DKSudo_pass
	if [ -z "${DKSudo_pass-}" ]; then
		### cmd_exe
		#[ ! command -v '${cmd_exe}' >/dev/null 2>&1 ] && export cmd_exe=$(command -v "cmd.exe") || return $?; 															# Test exist
		#[ "${cmd_exe-}" /c ver >/dev/null 2>&1 ] || { dk_call dk_error "cmd_exe:${cmd_exe-} failed to run"; return $?; }	
		#xport DKSudo_pass=$(${cmd_exe} /c echo %DKSudo_pass% | tr -d '\r'); 												# Test Execute
		export DKSudo_pass=builtin echo ${DKSudo_pass} | tr -d '\r'); 	
		dk_call dk_debug "DKSudo_pass = ${DKSudo_pass}";
	fi
	
	return $?;
}


sudo_exe() {
	dk_call dk_validate sudo "dk_call dk_depend sudo_exe";
	
	if [ -e "${sudo-}" ]; then	
		export command=${sudo};
		
		if [ -n "${DKSudo_pass-}" ]; then
			export command="echo ${DKSudo_pass} |& ${sudo} --stdin";
			[ -n "${builtin_exe-}" ] && export command="${builtin_exe} echo ${DKSudo_pass} |& ${sudo} --stdin";
			
		fi
		dk_call dk_debug "command = ${command}";
	fi
	
	builtin echo ${command} "$@";
	${command} "$@";

	#echo $?;
	return $?;
}
[ -z "${sudo_exe-}" ] && export sudo_exe=sudo_exe;







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	#dk_call dk_validate sudo_exe "dk_call dk_depend sudo_exe";

	sudo_exe ls && dk_call dk_success "sudo was successful" || dk_call dk_error "sudo failed";
	
	${sudo_exe} ls && dk_call dk_success "sudo was successful" || dk_call dk_error "sudo failed";
}