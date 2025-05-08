#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_tryCatch(function, args)
#
#	reference: https://stackoverflow.com/a/11092989/688352
#
dk_tryCatch() {
	dk_debugFunc 1
	
	# Don't pipe the subshell into anything or we won't be able to see its exit status
	set +e; ( set -e
		"${@}" 
	); err_status=${?}; set -e

	if [ "$err_status" -ne "0" ]; then
		echo "ERROR_STATUS: $err_status"
		#dk_call dk_pause
		#dk_call dk_error "test"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_tryCatch
}
