#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_fileExists(<file>)
#
#
dk_fileExists () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	#if [ -e "$1" ]; then
	#	dk_debug "dk_fileExists($*): FOUND"
	#else
	#	dk_warning "dk_fileExists($*): NOT FOUND!" 
	#fi
	[ -e "$1" ]
}