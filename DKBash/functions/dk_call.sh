#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_call(<command args>)
#
#
dk_call(){
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	if ! dk_commandExists ${1}; then
		if [[ "${1}" =~ ^dk_[a-zA-Z0-9]+ ]]; then	# Is it a dk_ prefixed function?
			dk_commandExists dk_load  || dk_source dk_load
			dk_commandExists ${1}     || dk_load ${1}
		else										# Not a dk_ prefixed function
			dk_install ${1}
		fi
		dk_commandExists ${1} || dk_error "${1}: command not found"
	fi
	
	#[ -z "$(command -v "dk_load")" ] && dk_source dk_load
	#[ -z "$(command -v "${1}")" ] && dk_load ${1}
	#[ -z "$(command -v "${1}")" ] && dk_source ${1}
	#[ -n "$(command -v "${1}")" ] || [$(read -rp '${1} command not found, press enter to exit')] || exit;
	
	dk_echo "${*}"
	"${@}"
}


DKTEST(){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_call dk_info "test message using dk_call"
}