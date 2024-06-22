#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_install(<package>)
#
#
dk_install (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"

	[ -n "$(command -v "$1")" ] && return    # 
	#if dk_packageInstalled $1; then
	#	dk_warning "$1 already dk_installed"
	#	return ${false};
	#fi
	
	dk_info "dk_installing $1"

	if dk_commandExists brew; then
		dk_call ${SUDO-} brew dk_install "$1"
	elif dk_commandExists apt; then
		dk_call ${SUDO-} apt -y dk_install "$1"
	elif dk_commandExists apt-get; then
		dk_call ${SUDO-} apt-get -y dk_install "$1"
	elif dk_commandExists pkg; then
		dk_call ${SUDO-} pkg dk_install "$1"
	elif dk_commandExists pacman; then
		dk_call ${SUDO-} pacman -S "$1" --noconfirm
	elif dk_commandExists apk; then
		dk_call ${SUDO-} apk add "$1"
	elif dk_commandExists tce-load; then
		dk_call ${SUDO-} tce-load -wil "$1"     #-l means don't add to boot
	else
		dk_error "ERROR: no package managers found"
	fi
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_install wget
}