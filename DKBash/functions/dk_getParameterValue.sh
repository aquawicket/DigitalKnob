#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


#################################################################################
# dk_getParameterValue(NAME)
#
dk_getParameterValue() {

	NAME="$1"
	_value_=""
	
	for (( a=2; a<$(($# + 1)); a++ )); do
		b=$(( a + 1 ))
		if [ "$NAME" = "${!a-}" ]; then
			[ "${!b-}" = "" ] && _value_="1" || _value_="${!b-}"
		fi
	done

	eval "${1}='${_value_}'"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
TEST_getParameter() {

#	dk_call dk_debugFunc 0 99

	dk_call dk_getParameterValue ARG1 "$@"
	dk_call dk_getParameterValue ARG2 "$@"
	dk_call dk_getParameterValue ARG3 "$@"
	dk_call dk_getParameterValue ARG4 "$@"
	dk_call dk_getParameterValue ARG5 "$@"
	dk_call dk_getParameterValue ARG6 "$@"
	dk_call dk_echo "ARG1 = ${ARG1}"
	dk_call dk_echo "ARG2 = ${ARG2}"
	dk_call dk_echo "ARG3 = ${ARG3}"
	dk_call dk_echo "ARG4 = ${ARG4}"
	dk_call dk_echo "ARG5 = ${ARG5}"
	dk_call dk_echo "ARG6 = ${ARG6}"
}


DKTEST() {

#	dk_call dk_debugFunc 0

	TEST_getParameter ARG1 "arg1 data" ARG3 ARG4 "arg4 data" ARG5 "arg5 data" ARG6
}


