#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_call(<command args>)
#
#
dk_call(){
	dk_debugFunc 1 99
	
	if ! dk_commandExists ${1}; then
		if [[ "${1}" =~ ^dk_[a-zA-Z0-9]+ ]]; then	# Is it a dk_ prefixed function?
			dk_source ${1}
	
	else	# Not a dk_ prefixed function								
			dk_commandExists dk_installPackage  || dk_source dk_installPackage
			dk_installPackage ${1}
		fi
		dk_commandExists ${1} || dk_error "${1}: command not found"
	fi
	
	"${@}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	dk_debugFunc 0
	
	dk_call dk_info "test message using dk_call"
}
