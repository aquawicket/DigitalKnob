#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_fileContains(file, string)
#
#
dk_fileContains() {
	dk_debugFunc
	[ -z "$2" ] && dk_error "file_contains <file.ext> <string> requires 2 parameters"
		
	grep -q "$2" "$1"
}