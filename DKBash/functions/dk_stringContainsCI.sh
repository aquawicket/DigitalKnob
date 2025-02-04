#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_stringContains(<string>, <substring>)
#
#
dk_stringContainsCI() {
	dk_debugFunc 2

	local string=$(dk_call dk_toLower "${1}")
	local substring=$(dk_call dk_toLower "${2}")
	# https://stackoverflow.com/a/8811800/688352
	# [[ ${1} == *"${2}"* ]]    							# NON-POSIX    # [[ ${string} == *"${substring}"* ]]
	# case "${1}" in *${2}*) return 0;; esac; return 1      # POSIX        # case "${string}" in *${substring}*) return 0;; esac; return 1
	[ "${string#*"$substring"}" != "$string" ]				# POSIX        # [ "${string#*"$substring"}" != "$string" ]
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	if dk_stringContainsCI "1ONE1" "one"; then
		dk_echo "1ONE1 contains one"
	else
		dk_echo "1ONE1 does not contain one"
	fi

	dk_stringContainsCI "1ONE1" "one" && dk_echo "1ONE1 contains one" || dk_echo "1ONE1 does not contain one"
	dk_stringContainsCI "2TWO2" "owt" && dk_echo "2TWO2 contains owt" || dk_echo "2TWO2 does not contain owt"
}
