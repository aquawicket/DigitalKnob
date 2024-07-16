#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_isEmpty(directory)
#
#
dk_isEmpty() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	if [ -d "${1}" ] && files=$(ls -qAH -- "${1}") && [ -z "${files}" ]; then
		#printf '%s\n' "$dir is an empty directory"
		return ${true}
	else
		#printf >&2 '%s\n' "$dir is not empty, or is not a directory" \
        #           "or is not readable or searchable in which case" \
        #            "you should have seen an error message from ls above."
		return ${false}
	fi
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_echo "PWD = $PWD"
	mkdir empty
	dk_echo "The created empty folder is ...."
    $(dk_isEmpty "${PWD}/empty") && dk_echo "Empty" || dk_echo "NOT Empty"
	dk_echo "the current directory is ..."
	$(dk_isEmpty "${PWD}") && dk_echo "Empty" || dk_echo "NOT Empty"
}
