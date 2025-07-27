#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_deleteTempFiles()
#
#
dk_deleteTempFiles() {
	dk_debugFunc 0

	dk_call dk_info "Deleting .TMP files . . ."
	
	dk_call dk_validate DK3RDPARTY_DIR	"dk_call dk_DK3RDPARTY_DIR"
	dk_call dk_validate DKCPP_APPS_DIR		"dk_call dk_DKBRANCH_DIR"
	dk_call dk_validate DKCPP_PLUGINS_DIR	"dk_call dk_DKBRANCH_DIR"
	
	[ ! -e "${DK3RDPARTY_DIR}" ] && return
	rm -rf $(find "${DK3RDPARTY_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DK3RDPARTY_DIR}" -type d -name *.TMP)
	find "${DK3RDPARTY_DIR}" -name "*.tmp" -delete
	find "${DK3RDPARTY_DIR}" -name "*.TMP" -delete
	
	[ ! -e "${DKCPP_APPS_DIR}" ] && return
	rm -rf $(find "${DKCPP_APPS_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DKCPP_APPS_DIR}" -type d -name *.TMP)
	find "${DKCPP_APPS_DIR}" -name "*.tmp" -delete
	find "${DKCPP_APPS_DIR}" -name "*.TMP" -delete
	
	[ ! -e "${DKCPP_PLUGINS_DIR}" ] && return
	rm -rf $(find "${DKCPP_PLUGINS_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DKCPP_PLUGINS_DIR}" -type d -name *.TMP)
	find "${DKCPP_PLUGINS_DIR}" -name "*.tmp" -delete
	find "${DKCPP_PLUGINS_DIR}" -name "*.TMP" -delete
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_deleteTempFiles
}
