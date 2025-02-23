#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_crlfToLf(file)
#
#	Convert a file with windows CRLF line endings to unix LF lined endings.
#
#	Reference: https://arueckauer.github.io/posts/2020/05/replace-crlf-with-lf-in-bash
#
dk_crlfToLf() {
	dk_debugFunc 1
	
	_file_=$1
	dk_call dk_assertPath ${_file_}
	
	#cat ${_file_} | sed 's/\r$//' > ${_file_}

	sed -i 's/\r//g' ${_file_} & $(true)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_crlfToLf TODO
}
