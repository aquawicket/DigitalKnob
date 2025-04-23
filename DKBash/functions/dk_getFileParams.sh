#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_getFileParams(filepath)
#
# todo: add optional 3rd parameter for output value
dk_getFileParams() {
    dk_debugFunc 1
    
	for line in $(cat "$1"); do
		IFS='=' read -r A B <<< "$line"
		echo "$A = $B"
		export "$A=$B"
	done
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
  
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
    dk_call dk_getFileParams ${DKBRANCH_DIR}/dkconfig.txt
	echo "dk_getAllFileParams_ENABLE = ${dk_getAllFileParams_ENABLE}"
}
