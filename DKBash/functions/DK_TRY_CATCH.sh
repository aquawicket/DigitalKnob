#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_tryCatch(function, args)
#
#	reference: https://stackoverflow.com/a/11092989/688352
#
dk_tryCatch (){
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	# Don't pipe the subshell into anything or we won't be able to see its exit status
	set +e; ( set -e
		"${@}" 
	); err_status=${?}; set -e

	if [ "$err_status" -ne "0" ]; then
		echo "ERROR_STATUS: $err_status"
		#dk_pause
		#dk_error "test"
	fi
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_tryCatch
}