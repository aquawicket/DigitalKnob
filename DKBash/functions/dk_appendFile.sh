#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_appendFile(string, file)
#
#
dk_appendFile() {
	dk_debugFunc
	[ -z "$2" ] && dk_error "append_file <string> <file.ext> requires 2 parameters"
	
	echo "$1" >> $2
}