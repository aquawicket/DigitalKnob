#!/usr/bin/env bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


############ dk_getFileParams settings #########################################
# [ -z "${dk_getAllFileParams_PRINT_VARIABLES}" ] && export dk_getFileParams_PRINT_VARIABLES=1
################################################################################
# dk_getFileParams(<file>)
#
#
dk_getFileParams() {
    dk_debugFunc 1
    
	_file_="${1}"
	
	if [ "${dk_getFileParams_PRINT_VARIABLES-}" = "1" ];then
		dk_call dk_debug "### ${_file_} Parameters ###"
	fi
	
	# IFS= (or IFS='') prevents leading/trailing whitespace from being trimmed.
	# -r prevents backslash escapes from being interpreted.
	while IFS='' read -r line; do
		#echo "line = ${line}"
		IFS='= ' read -r A B <<< ${line%%#*} # read up to # using = and 'space' as delimiters
		[ "${A}" = "" ] && continue # if A is empty, skip
		[ "${B}" = "" ] && continue # if A is empty, skip
		eval export ${A}=${B} # evaluate to expand any variables
		
		[ "${dk_getFileParams_PRINT_VARIABLES-}" = "1" ] && dk_call dk_debug "'${A}' = '${!A}'"
	done < "${_file_}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
	
	dk_getFileParams_PRINT_VARIABLES=1
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_getFileParams "${DKBRANCH_DIR}/dkconfig.txt"
}
