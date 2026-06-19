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


################################################################################
# dk_gitBundle(repo_path, bundle_file) OVERWRITE
#
#
dk_gitBundle() {
	dk_debugFunc 2 3;
   
	[ -n "$1" ] && repo_path="$1";
	[ -n "$2" ] && bundle_file="$2";
	[ "$3" = "OVERWRITE" ] && OVERWRITE=1 || OVERWRITE=0;

	###### error if repository doesn't exist
	if [ ! -e "${repo_path}/.git" ]; then
		dk_call dk_error "${repo_path} is not a path to a repository";
		return $?;
	fi
		
	if [ -e "${bundle_file}" ]; then
		if [ ! "${OVERWRITE}" = "1" ]; then
			dk_call dk_error "dk_gitBundle Cannot create backup. Destiantion already exists and OVERWRITE is NOT set";
		fi
		dk_call dk_delete "${bundle_file}";
	fi
	
	dk_call dk_validate git_exe "dk_call dk_depend git";
	
	####### Back up the repositiory to a bundle_file
	#git -C <repo_path> bundle create <bundle_file> --all
	"${git_exe}" -C "${repo_path}" bundle create "${bundle_file}" --all;
	
	#dk_call dk_sftpUpload "${bundle_file}";
}






####### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR";
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR";
    dk_call dk_gitBundle "${DKBRANCH_DIR}" "${DKDOWNLOAD_DIR}/DigitalKnob.bundle" OVERWRITE;
}
