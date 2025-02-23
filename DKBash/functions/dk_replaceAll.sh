#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" <output_variable>)
#
#
dk_replaceAll() {
	dk_debugFunc 3 4
	
    input="${1}"
	searchValue="${2}"
	newValue="${3}"
    _replaceAll_=
		
    while [ -n "${input}" ]; do
        LEFT=${input%%"${searchValue}"*}

        if [ "${LEFT}" = "${input}" ]; then
            _replaceAll_=${_replaceAll_}${input}
			break
        fi

        _replaceAll_=${_replaceAll_}${LEFT}${newValue}
        input=${input#*"$searchValue"}
    done
	
	### return value ###
	dk_call dk_printVar _replaceAll_
	[ ${#} -gt 3 ] && eval "${4}='${_replaceAll_}'" && return  # return value when using rtn_var parameter 
	dk_return ${_replaceAll_}; return						  # return value when using command substitution
	
#DEBUG
#	dk_printVar _replaceAll_
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	string_var="AZC AZC Zannana Zread"
	echo "string before:  ${string_var}"
	
	dk_replaceAll "${string_var}" "Z" "B" string_var
	
	echo "string after:  ${string_var}"
}