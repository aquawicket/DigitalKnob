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


############################# dk_exec SETTINGS ###################################
[ -z "${dk_exec_ECHO_OUTPUT-}" ]	&& dk_exec_ECHO_OUTPUT="0"
[ -z "${dk_exec_ECHO_ERROR-}" ]		&& dk_exec_ECHO_ERROR="0"

#dk_exec_PRINT_CALL=1 		# dk_exec_call
#dk_exec_PRINT_COMMAND=1 	# dk_exec_command
#dk_exec_PRINT_EXITCODES=1	# dk_exec_exitcodes
#dk_exec_PRINT_EXITCODE=1	# dk_exec_exitcode
#dk_exec_PRINT_STDERR=1		# dk_exec_stderr[]
#dk_exec_PRINT_STDOUT=1		# dk_exec_stdout[]
#dk_exec_PRINT_OUTPUT=1		# dk_exec
##################################################################################
# dk_exec()
#
#	In Bash, the exec command replaces the bash context completley. This is not
#	how we use dk_exec in the other languages. More review needed before continuing
#	work on this function. Particularly the name of the function is in question.
#
dk_exec() {
	dk_debugFunc 1 99
	
	export dk_exec=$(${1} ${@:2})
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_exec "/c/Windows/System32/cmd.exe" //V:ON //c call ${DKBATCH_FUNCTIONS_DIR_}dk_test.cmd ${@:2}
	dk_call dk_debug "dk_exec = ${dk_exec}"
}
										
