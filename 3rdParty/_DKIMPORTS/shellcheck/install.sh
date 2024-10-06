#!/bin/sh

###### Load Function files ######
. ../../../DKBash/functions/DK.sh

SHELLCHECK_VERSION="v0.10.0"
dk_validate host_os "dk_host_triple"
dk_printVar host_os
dk_printVar host_arch
[ "${host_os}_${host_arch}" == "linux_arm" ]    && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.linux.armv6hf.tar.xz"
[ "${host_os}_${host_arch}" == "linux_arm64" ]  && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.aarch64.tar.xz"
[ "${host_os}_${host_arch}" == "linux_x86_64" ] && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
[ "${host_os}_${host_arch}" == "mac_x86_64" ]   && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.x86_64.tar.xz"
[ "${host_os}_${host_arch}" == "mac_arm64" ]    && SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.darwin.aarch64.tar.xz"
dk_assertVar SHELLCHECK_DL_FILE
dk_printVar SHELLCHECK_DL_FILE

dk_validate DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR"
dk_download "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/${SHELLCHECK_DL_FILE}" "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}"

dest_path="${DKTOOLS_DIR}/shellcheck-${SHELLCHECK_VERSION}"
dk_smartExtract "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}" "${dest_path}"
SHELLCHECK_EXE="${dest_path}/shellcheck"

#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
"${SHELLCHECK_EXE} --version"	
