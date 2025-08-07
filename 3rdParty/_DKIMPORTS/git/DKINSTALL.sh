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


dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
if [ ! -e "${DKIMPORTS_DIR}/git/dkconfig.txt" ];then
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt"  "${DKIMPORTS_DIR}/git/dkconfig.txt"
fi
dk_call dk_getFileParams "${DKIMPORTS_DIR}/git/dkconfig.txt"


#:: https://stackoverflow.com/a/67714373
dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
[ -z "${GIT_CONFIG_SYSTEM-}" ] && export GIT_CONFIG_SYSTEM="${DKCACHE_DIR}/.gitSystem"
[ -z "${GIT_CONFIG_GLOBAL-}" ] && export GIT_CONFIG_GLOBAL="${DKCACHE_DIR}/.gitGlobal"

####################################################################
# DKINSTALL
#
DKINSTALL() {
	#dk_call dk_debugFunc 0	
	#echo "DKINSTALL($*)"
	
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple"

	git_Import_Var="git_${Host_Tuple}_Import"
	git_Import="${!git_Import_Var}"
    dk_call dk_assertVar git_Import
  
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	[ -z "${GIT-}" ] && dk_call dk_importVariables ${git_Import} NAME git ROOT ${DKTOOLS_DIR}
	#[ -z "${GIT-}" ] && dk_call dk_importVariables ${git_Import} ROOT ${DKTOOLS_DIR}
	dk_call dk_assertVar GIT
	
	# https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	############ DO NOT USE GIT_DIR ############
	[ -n "${GIT_DIR-}" ] && dk_call dk_fatal "ERROR: GIT_DIR should not be set."   # https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	############ DO NOT USE GIT_DIR ############
	
    export GIT_EXE="${GIT}/bin/git.exe"
	export GIT_BASH_EXE="${GIT}/bin/bash.exe"
    # export GIT-BASH_EXE="${GIT}/git-bash.exe"
	# export GIT_PATCH_EXE="${GIT}/usr/bin/patch.exe"
    [ -e "${GIT_EXE}" ] && return
	
	###### INSTALL ######
    dk_call dk_echo 
    dk_call dk_info "Installing git . . ."
	if dk_call dk_isUrl "${git_Import}"; then
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download ${git_Import}
		"${DKDOWNLOAD_DIR}/${GIT_IMPORT_FILE}" -y -o "${GIT}"
	else
		dk_call dk_installPackage git
		(command -v git) && export GIT_EXE=$(command -v git)
	fi
	
    ###### Install Git Context Menu ######
    #dk_call dk_depend git/contextMenu  
	 
    [ ! -e "${GIT_EXE}" ] && dk_call dk_error "cannot find git"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_call dk_debugFunc 0

	dk_call DKINSTALL
	dk_call dk_echo "GIT = ${GIT}"
	dk_call dk_echo "GIT_EXE = ${GIT_EXE}"
}
