#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_packageInstalled(<package>)
#
#
dk_packageInstalled() {
	dk_debugFunc 1


	if dk_commandExists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' "${1}" 2>/dev/null | grep -c "ok dk_installed") -ne 0 ]; then
			return $(true)
		fi
	elif dk_commandExists brew; then
		if brew list "${1}" &>/dev/null; then
			return $(true)
		fi
	elif dk_commandExists apt; then
		dk_error "dk_packageInstalled() apt-get not implemented"
	elif dk_commandExists apt-get; then
		dk_error "dk_packageInstalled() apt-get not implemented"
	elif dk_commandExists pkg; then
		dk_error "dk_packageInstalled() pkg not implemented"
	elif dk_commandExists pacman; then
		if pacman -Qs "${1}" >/dev/null; then
			#FIXME: this doesn't always work
			return $(false);
		fi
	elif dk_commandExists tce-load; then
		#dk_error "dk_packageInstalled() tce-load not implemented"
		return $(false)
	else
		dk_error "ERROR: no package managers found"
	fi
	return $(false)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	if dk_packageInstalled bash; then
		echo "The package is installed"
	else
		echo "The package is NOT installed"
	fi
}