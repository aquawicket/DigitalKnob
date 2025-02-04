#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_bundleSource(<files_list> <output_file>)
#
#	Bundle multiple .sh files into 1 .sh file.
#
dk_bundleSource() {
	dk_debugFunc 2

	file_list=${1}
	output_file=${2}
	
	# dk_load has ;; seperators in it's list.  convert them to single ;
	dk_call dk_replaceAll "${file_list}" ";;" ";" file_list
	dk_call dk_echo file_list = ${file_list}
	dk_call dk_pause
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_bundleSource
}
