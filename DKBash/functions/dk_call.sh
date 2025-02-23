#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_call(<command args>)
#
dk_call(){
	dk_debugFunc 1 99
	
	if ! (command -v ${1} &>/dev/null); then
		
		# Is it a dk_ prefixed function?
#	if [[ "${1}" =~ ^dk_[a-zA-Z0-9]+ ]]; then
			dk_source ${1}	
		
		# Not a dk_ prefixed function
#		else								
#			(command -v dk_installPackage &>/dev/null) || dk_source dk_installPackage
#			dk_installPackage ${1}
#		fi
		
		
		if ! (command -v ${1} &>/dev/null); then
			(command -v dk_fatal &>/dev/null) || dk_source dk_fatal
			dk_fatal "${1}: command not found"
		fi
	fi
	
	#echo "dk_call: $*" &>2
	"${@}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	dk_debugFunc 0
	
	dk_call dk_info "test message using dk_call"
}
