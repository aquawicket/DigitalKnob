#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_getDirectories(<path> <output>)
#
#   reference: https://stackoverflow.com/a/138581
#
dk_getDirectories() {
	dk_debugFunc 2

	#directories=(${1}/*/)    # This creates an array of the full paths to all subdirs
	#arr=("${arr[@]%/}")            # This removes the trailing slash on each item
	#arr=("${arr[@]##*/}")          # This removes the path prefix, leaving just the dir names
	eval "${2}=(${1}/*/)" 
	#dk_call dk_printVar "${2}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myPath "/c/Windows"
	dk_call dk_getDirectories "${myPath}" directories
	dk_call dk_printVar directories
}
