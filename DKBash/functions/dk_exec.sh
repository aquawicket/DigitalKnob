#!/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################

::######################### dk_exec SETTINGS #########################
[ -z "${dk_exec_ECHO_OUTPUT}" ] && dk_exec_ECHO_OUTPUT="0"
[ -z "${dk_exec_ECHO_ERROR}" ]	&& dk_exec_ECHO_ERROR="0"

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
										
