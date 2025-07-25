#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
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