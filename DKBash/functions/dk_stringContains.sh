#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_stringContains(string, substring)
#
#
dk_stringContains() {
	dk_debugFunc 2

	
	# https://stackoverflow.com/a/8811800/688352
	# [[ ${1} == *"${2}"* ]]    							# NON-POSIX    # [[ ${string} == *"${substring}"* ]]
	# case "${1}" in *${2}*) return 0;; esac; return 1      # POSIX        # case "${string}" in *${substring}*) return 0;; esac; return 1
	[ "${1#*"${2}"}" != "${1}" ]						    # POSIX        # [ "${string#*"$substring"}" != "$string" ]
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	if dk_stringContains "1one1" "one"; then
		dk_echo "1one1 contains one"
	else
		dk_echo "1one1 does not contains one"
	fi

	dk_stringContains "1one1" "one" && dk_echo "1one1 contains one" || dk_echo "1one1 does not contain one"
	dk_stringContains "2two2" "owt" && dk_echo "2two2 contains owt" || dk_echo "2two2 does not contain owt"
}
