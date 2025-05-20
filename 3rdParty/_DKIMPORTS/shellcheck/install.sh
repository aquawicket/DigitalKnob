#!/usr/bin/env sh

###### Load Function files ######
. ../../../DKBash/functions/DK.sh

SHELLCHECK_VERSION="v0.10.0"
dk_validate Host_Tuple "dk_Host_Tuple"
dk_printVar Host_Os
dk_printVar Host_Arch
[ "${Host_Os}_${Host_Arch}" == "Linux_Arm32" ]    && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.linux.armv6hf.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "Linux_Arm64" ]  && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.aarch64.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "linux_x86_64" ] && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "mac_x86_64" ]   && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.x86_64.tar.xz"
[ "${Host_Os}_${Host_Arch}" == "mac_arm64" ]    && SHELLCHECK_IMPORT_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.aarch64.tar.xz"
dk_assertVar SHELLCHECK_IMPORT_FILE
dk_printVar SHELLCHECK_IMPORT_FILE

dk_validate DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR"
dk_download "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/${SHELLCHECK_IMPORT_FILE}" "${DKDOWNLOAD_DIR}/${SHELLCHECK_IMPORT_FILE}"

dest_path="${DKTOOLS_DIR}/shellcheck-${SHELLCHECK_VERSION}"
dk_smartExtract "${DKDOWNLOAD_DIR}/${SHELLCHECK_IMPORT_FILE}" "${dest_path}"
SHELLCHECK_EXE="${dest_path}/shellcheck"

#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
"${SHELLCHECK_EXE} --version"	
