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

SHELLCHECK_VERSION="v0.10.0"
dk_validate Host_Tuple "dk_Host_Tuple"
dk_printVar Host_Os
dk_printVar Host_Arch
[ "${Host_Os}_${Host_Arch}" == "Linux_Arm32" ]    && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.linux.armv6hf.tar.xz"
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
SHELLCHECK_EXE="${dest_path}/shellcheck"

#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
"${SHELLCHECK_EXE} --version"	
