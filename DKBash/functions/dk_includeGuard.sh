#!/bin/sh
[ -n "$inclue_guard_dk_includeGuard" ] && return || export readonly inclue_guard_dk_includeGuard=1
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"



##################################################################################
# dk_includeGuard()
#
#
alias dk_includeGuard='{
	[ -z ${BASH_SOURCE[0]} ] && dk_echo "BASH_SOURCE[0] is empty"
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	filename=${filename##*\\}
	name="${filename%.*}"
	eval value=\${include_guard_$name}
	
	if [ -n "${value}" ]; then
		dk_warning "${path} already included"
		return 1 2>/dev/null
		dk_exit 1
	else	
		export readonly include_guard_${name}=1
	fi
}'





DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	. ${DKBASH_FUNCTIONS_DIR}/dk_debug
	. ${DKBASH_FUNCTIONS_DIR}/dk_debug
	dk_debug "testing dk_includeGuard. loading of dk_debug should have been stopped twice."
}
