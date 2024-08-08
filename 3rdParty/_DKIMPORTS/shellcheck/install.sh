#!/bin/sh

###### Load Function files ######
. ../../../DKBash/functions/DK.sh

SHELLCHECK_VERSION="v0.10.0"
dk_validate HOST_OS "dk_getHostTriple"
dk_printVar HOST_OS
dk_printVar HOST_ARCH
[ "${HOST_OS}_${HOST_ARCH}" == "linux_arm" ]    && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.linux.armv6hf.tar.xz"
[ "${HOST_OS}_${HOST_ARCH}" == "linux_arm64" ]  && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.aarch64.tar.xz"
[ "${HOST_OS}_${HOST_ARCH}" == "linux_x86_64" ] && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
[ "${HOST_OS}_${HOST_ARCH}" == "mac_x86_64" ]   && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.x86_64.tar.xz"
[ "${HOST_OS}_${HOST_ARCH}" == "mac_arm64" ]    && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.aarch64.tar.xz"
dk_assert SHELLCHECK_DL_FILE
dk_printVar SHELLCHECK_DL_FILE

dk_validate DKDOWNLOAD_DIR "dk_getDKPaths"
dk_download "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/${SHELLCHECK_DL_FILE}" "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}"

dest_path="${DKTOOLS_DIR}/shellcheck-${SHELLCHECK_VERSION}"
dk_smartExtract "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}" "${dest_path}"
SHELLCHECK_EXE="${dest_path}/shellcheck"

#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
"${SHELLCHECK_EXE} --version"	
