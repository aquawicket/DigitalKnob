#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_bundleSource(<files_list> <output_file>)
#
#	Bundle multiple .sh files into 1 .sh file.
#
dk_bundleSource (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	file_list=${1}
	output_file=$2
	
	# dk_load has ;; seperators in it's list.  convert them to single ;
	dk_replaceAll "$file_list" ";;" ";" file_list
	echo file_list = $file_list
	dk_pause
	

}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_bundleSource
}