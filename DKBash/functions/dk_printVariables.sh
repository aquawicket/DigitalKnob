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


##################################################################################
# dk_printVariables()
#
#
alias dk_printVariables='{
	dk_debugFunc
	
	# https://mywiki.wooledge.org/BashSheet
	# https://www.adminschoice.com/bash-positional-parameters
	
	echo "\${FUNCNAME} = ${FUNCNAME}"
	echo "\${FUNCNAME[0]} = ${FUNCNAME[0]}"
	echo "\${FUNCNAME[1]} = ${FUNCNAME[1]}"
	echo "\${0} = ${0}" # Expands to bash script file name or bash shell.
	echo "\${@} = ${@}"	# Lists all command line parameters in a array format.
	echo "\${*} = ${*}"	# Lists all the command line parameters in a single string format.
	echo "\${#} = ${#}" # Numeric count of the command line argument.
	echo "\${?} = ${?}" # Returns the exit status of last executed process.
	echo "\${!} = ${!}" # Gives the process ID of the last job placed into the background
	echo "\$$ = $$" # Expands to the process ID of the shell or invoking shell in case of subshell.
	echo "\$_ = $_" # last argument of the last command that was executed.
	echo "\$- = $-" # List special parameters set for bash.
}'



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_printVariables
}