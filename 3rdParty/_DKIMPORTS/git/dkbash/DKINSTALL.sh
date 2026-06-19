#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
if [ ! -e "${DKIMPORTS_DIR}/git/dkconfig.txt" ];then
	dk_call dk_download "http://aquawicket.com/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt"  "${DKIMPORTS_DIR}/git/dkconfig.txt"
fi
dk_call dk_fileVariables "${DKIMPORTS_DIR}/git/dkconfig.txt"


#:: https://stackoverflow.com/a/67714373
dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
[ -z "${GIT_CONFIG_SYSTEM-}" ] && export GIT_CONFIG_SYSTEM="${DKCACHE_DIR}/.gitSystem"
[ -z "${GIT_CONFIG_GLOBAL-}" ] && export GIT_CONFIG_GLOBAL="${DKCACHE_DIR}/.gitGlobal"

####################################################################
# DKINSTALL
#
DKINSTALL() {
	dk_debugFunc 0;

	dk_call dk_fileVariables "${PWD}/dkconfig.txt";
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple";
	git_Import_Var="git_${Host_Tuple}_Import";
	git_Import="${!git_Import_Var}";
	[ -z "${git_Import}" ] && git_Import="git";		# default to 'git' package if no download found
	dk_call dk_assertVar git_Import;
	
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
	[ -z "${git-}" ] && dk_call dk_importVariables ${git_Import} INSTALL_ROOT ${DKTOOLS_DIR};
	dk_call dk_assertVar git;
	
	# https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	############ DO NOT USE GIT_DIR ############
	[ -n "${GIT_DIR-}" ] && dk_call dk_fatal "ERROR: GIT_DIR should not be set."   # https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	############ DO NOT USE GIT_DIR ############
	
    export git_exe="${git}/bin/git.exe"
	export git_bash_exe="${git}/bin/bash.exe"
    # export git-bash_exe="${git}/git-bash.exe"
	# export git_patch_exe="${git}/usr/bin/patch.exe"
    [ -e "${git_exe}" ] && return
	
	###### INSTALL ######
    dk_call dk_echo 
	if dk_call dk_isUrl "${git_Import}"; then
		dk_call dk_info "Installing ${git_Import} . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download ${git_Import}
		"${DKDOWNLOAD_DIR}/${git_import_file}" -y -o "${git}"
	else
		dk_call dk_info "Installing ${git_Import} package . . ."
		dk_call dk_installPackage git
		(command -v git) && export git_exe=$(command -v git)
	fi
	
    ###### Install Git Context Menu ######
    #dk_call dk_depend git/contextMenu  
	 
#   [ ! -e "${git_exe}" ] && dk_call dk_error "cannot find git"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call DKINSTALL
	dk_call dk_echo "git = ${git}"
	dk_call dk_echo "git_exe = ${git_exe}"
}
