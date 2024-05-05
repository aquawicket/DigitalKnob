#!/bin/sh

###### Load Function files ######
. ../../../DKBash/functions/DK

SHELLCHECK_VERSION="v0.10.0"
SHELLCHECK_DL_FILE="shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
dk_printVar SHELLCHECK_DL_FILE
dk_validate DKDOWNLOAD_DIR "dk_getDKPaths"
dk_download "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/${SHELLCHECK_DL_FILE}" "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}"


##### dk_install_extract(src_path dest_path) #####
dk_info "Extracting ${SHELLCHECK_DL_FILE}"
	
dk_validate DK3RDPARTY_DIR "dk_validateBranch"
dest_path="${DK3RDPARTY_DIR}/shellcheck-${SHELLCHECK_VERSION}"
dk_smartExtract "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}" "${dest_path}"

	
#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
#shellcheck --version

exec $SHELL