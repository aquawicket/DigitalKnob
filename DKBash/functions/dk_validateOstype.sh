#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_validateOstype()
#
#
#dk_validateOstype () {
#	dk_debugFunc
#	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
#	
#	if [ -e /proc/device-tree/model ]; then
#		MODEL=$(tr -d '\0' </proc/device-tree/model)
#	fi
#
#	if [ "$OSTYPE" = "linux-gnu"* ]; then
#		DIGITALKNOB_DIR="/home/$USER/digitalknob"
#	elif [ "$OSTYPE" = "darwin"* ]; then
#		DIGITALKNOB_DIR="/Users/$USER/digitalknob"
#	elif [ "$OSTYPE" = "cygwin" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob"
#	elif [ "$OSTYPE" = "msys" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob"
#	elif [ "$OSTYPE" = "win32" ]; then #I'm not sure this can happen
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob" 
#	elif [ "$OSTYPE" = "freebsd"* ]; then
#		dk_error "TODO: freebsd builder incomplete"
#	elif [ "$OSTYPE" = "linux-android" ]; then
#		DIGITALKNOB_DIR="/data/data/com.termux/files/home/digitalknob"
#	else
#		dk_error "UNKNOWN OS ($OSTYPE)"
#	fi
#}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validateOstype
}