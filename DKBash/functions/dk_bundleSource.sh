#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_bundleSource(<files_list> <output_file>)
#
#	Bundle multiple .sh files into 1 .sh file.
#
dk_bundleSource () {
	dk_debugFunc
	[ "$#" -lt "2" ] && dk_error "Incorrect number of parameters"
	
	file_list=$1
	output_file=$2
	
	# dk_load has ;; seperators in it's list.  convert them to single ;
	dk_replaceAll "$file_list" ";;" ";" file_list
	echo file_list = $file_list
	dk_pause
	

}




################################ DKTEST #########################################
[ -n "$DKTEST" ] && {

	echo "TODO"
	
} && exec $SHELL