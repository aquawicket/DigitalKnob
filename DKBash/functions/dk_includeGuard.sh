#!/usr/bin/env sh
[ -n "$inclue_guard_dk_includeGuard" ] && return || export readonly inclue_guard_dk_includeGuard=1
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_includeGuard()
#
#
alias dk_includeGuard='{
	[ -z ${BASH_SOURCE[0]} ] && dk_call dk_echo "BASH_SOURCE[0] is empty"
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	filename=${filename##*\\}
	name="${filename%.*}"
	eval value=\${include_guard_$name}
	
	if [ -n "${value}" ]; then
		dk_call dk_warning "${path} already included"
		return 1 2>/dev/null
		dk_call dk_exit 1
	else	
		export readonly include_guard_${name}=1
	fi
}'





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	. ${DKBASH_FUNCTIONS_DIR}/dk_debug
	. ${DKBASH_FUNCTIONS_DIR}/dk_debug
	dk_call dk_debug "testing dk_includeGuard. loading of dk_debug should have been stopped twice."
}
