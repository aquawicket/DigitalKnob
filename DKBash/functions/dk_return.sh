#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

ORIGINAL_IFS=${IFS}
##################################################################################
# dk_return()
#
alias dk_return='ret_val "${ret_val-}"'
ret_val() {
	if [ "${1-}" = "" ]; then
		[ -z "${2-}" ] && return $(false)
		[ -v "${2-}" ] && if [ ${2-} -gt 9 ]; then  # [ ${2-} -gt 9 ] = don't test names that match 0-9, positional parameters
			#echo "is variable"
			if [[ "$(declare -p ${2-})" =~ "declare -a" ]]; then
				#echo "is array"
				eval local array='("${'${2-}'[@]}")'
				printf "%s\n" "${array[@]}"
				export IFS=${ORIGINAL_IFS}
			fi
			return $(true);
		fi
		
		builtin echo "${2-}"
		#trap '' EXIT
		#exit
	else
		eval "${ret_val-}='${2-}'"
		unset ret_val
	fi
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_return "return string value"; return
}