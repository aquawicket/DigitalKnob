#!/bin/sh
[ -n "$inclue_guard_dk_includeGuard" ] && return || export readonly inclue_guard_dk_includeGuard=1
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"



##################################################################################
# dk_includeGuard()
#
#
alias dk_includeGuard='{
	[ -z ${BASH_SOURCE[0]} ] && echo "BASH_SOURCE[0] is empty"
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	filename=${filename##*\\}
	name="${filename%.*}"
	eval value=\${include_guard_$name}
	
	if [ -n "$value" ]; then
		echo "already included"
		return 1 2>/dev/null
		exit 1
	else	
		export readonly include_guard_${name}=1
	fi
	
	#######################################
	#if [ -n "$value" ]; then
	#	[ -n "$(echo -e)" ] && dkecho="echo -e" || dkecho="echo"
	#	$dkecho "[31m dk_includeGuard(): $filename already included [0m"
	#	return
	#fi
	
	#readonly include_guard_${name}=1
	### $dkecho "[36m added include_guard_$name [0m"
}'





DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	. ${DKBASH_DIR}/functions/dk_debug
	. ${DKBASH_DIR}/functions/dk_debug

	dk_debug "testing dk_includeGuard. loading of dk_debug should have been stopped twice."

}