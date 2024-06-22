#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_getDirectories(<path> <output>)
#
#   reference: https://stackoverflow.com/a/138581
#
dk_getDirectories (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	

	#directories=($1/*/)    # This creates an array of the full paths to all subdirs
	#arr=("${arr[@]%/}")            # This removes the trailing slash on each item
	#arr=("${arr[@]##*/}")          # This removes the path prefix, leaving just the dir names
	eval "$2=($1/*/)" 
	#dk_printVar "${2}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getDirectories /c/Windows/System32 output

}