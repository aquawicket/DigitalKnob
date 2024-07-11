#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_readlink(<path> <output>)
#
#    reference: https://stackoverflow.com/a/1116890/688352
#	macOs: https://www.unix.com/man-page/osx/1/readlink/
#
#	example: dk_return "$(dk_readlink -f "$path")"; return 
#
dk_readlink (){
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 3 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	

	# test $(readlink -f "%2")
	# fallback on the code below upon failure	
#	if $(readlinkbob -f "${2}"); then
#		dk_echo "using readlink -f ${2}"
#		builtin echo $(readlink -f "${2}")
#		
#	elif $(readlink "${2}"); then
#		dk_echo "using readlink ${2}"
#		
#		builtin echo $(readlink "${2}")
#	else
		dk_echo "using dk_readlink -f ${2}"
		target_file=${2}   # we expect to use a -f parameter, so use ${2} as the input path.

		cd $(dirname $target_file)
		target_file=$(basename $target_file)

		# Iterate down a (possible) chain of symlinks
		while [ -L "$target_file" ]
		do
			target_file=$(readlink $target_file)
			cd $(dirname $TARGET_FILE)
			target_file=$(basename $target_file)
		done

		# Compute the canonicalized name by finding the physical path 
		# for the directory we're in and appending the target file.
		phys_dir=$(pwd -P)
		readlinkPath=$phys_dir/$target_file
		builtin echo $readlinkPath
#	fi
	#eval "${2}=${readlinkPath}"
	#dk_printVar "${2}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	_readlink=$(dk_readlink -f "dk_load.sh")
	echo "_readlink = ${_readlink}"
}