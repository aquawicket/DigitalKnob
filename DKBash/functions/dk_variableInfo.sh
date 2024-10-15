#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_variable_info(name output)
#
#
dk_variable_info() {
	dk_debugFunc 2
	
	[ ${#} -ne 2 ] && return $(false)										# if not exactly 2 parameters
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# ^ as first character is not portable
	#$(expr "${2}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# ^ as first character is not portable
	$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	$(expr "${2}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	
	#FIXME: this only gets the first element of an array variable
	if dk_call dk_defined ${1}; then
		eval value='$'{$1}
		eval "${2}=\"${1} = '${value}'\""
	else
		eval "${2}=\"${1} = ${red}NOT DEFINED${clr}\""
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_variable_info
}
