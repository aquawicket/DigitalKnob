#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" <output_variable>)
#
#
dk_replaceAll (){
	dk_debugFunc
	[ $# -ne 4 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
    input="$1"
	searchValue="$2"
	newValue="$3"
    output=
		
    while [ -n "${input}" ]; do
        LEFT=${input%%"${searchValue}"*}

        if [ "${LEFT}" = "${input}" ]; then
            output=${output}${input}
			break
        fi

        output=${output}${LEFT}${newValue}
        input=${input#*"$searchValue"}
    done
	
	dk_printVar output
	eval "$4='$output'"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	string_var="AZC AZC Zannana Zread"
	echo "string before:  ${string_var}"
	
	dk_replaceAll "${string_var}" "Z" "B" string_var
	
	echo "string after:  ${string_var}"
}