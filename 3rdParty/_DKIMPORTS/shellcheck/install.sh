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

SHELLCHECK_VERSION="v0.10.0"
dk_validate Host_Tuple "dk_Host_Tuple"
dk_printVar Host_Os
dk_printVar Host_Arch
[ "${Host_Os}_${Host_Arch}" == "Linux_Arm32" ]  && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.linux.armv6hf.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "Linux_Arm64" ]  && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.aarch64.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "Linux_X86_64" ] && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "Mac_X86_64" ]   && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.x86_64.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "Mac_Arm64" ]    && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.aarch64.tar.xz"
dk_assertVar SHELLCHECK_IMPORT_FILE
dk_printVar SHELLCHECK_IMPORT_FILE

dk_validate DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR"
dk_download "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/${SHELLCHECK_IMPORT_FILE}" "${DKDOWNLOAD_DIR}/${SHELLCHECK_IMPORT_FILE}"

dest_path="${DKTOOLS_DIR}/shellcheck-${SHELLCHECK_VERSION}"
dk_smartExtract "${DKDOWNLOAD_DIR}/${SHELLCHECK_IMPORT_FILE}" "${dest_path}"
shellcheck_exe="${dest_path}/shellcheck"

#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
"${shellcheck_exe} --version"	
