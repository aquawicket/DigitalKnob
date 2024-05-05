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
	#dk_extract "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}" "${dest_path}"
	dk_smartExtract "${DKDOWNLOAD_DIR}/${SHELLCHECK_DL_FILE}" "${dest_path}"
	return
	
	
	if dk_fileExists "${DKDOWNLOAD_DIR}/UNZIPPED"; then 
		dk_remove "${DKDOWNLOAD_DIR}/UNZIPPED"
	fi
	dk_makeDirectory "${DKDOWNLOAD_DIR}/UNZIPPED"
	
	
	
	# We either have a root folder in /UNZIPPED, or multiple files without a root folder
	cd "${DKDOWNLOAD_DIR}/UNZIPPED"
	file_count=$(ls -1 | wc -l)
	cd "${OLDPWD}"
	dk_printVar file_count

	if [ ${file_count} -gt 2 ]; then ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
		#Zip extracted with no root folder, Rename UNZIPPED to dest_path
		dk_rename "${DKDOWNLOAD_DIR}/UNZIPPED" "${dest_path}" # OVERWRITE
	else 
		if [ -e "${DKDOWNLOAD_DIR}/UNZIPPED/${dest_filename}" ]; then ##Zip extracted to expected folder. move
			dk_rename "${DKDOWNLOAD_DIR}/UNZIPPED/${dest_filename}" "${dest_path}" # OVERWRITE
			dk_remove "${DKDOWNLOAD_DIR}/UNZIPPED"
		#file extracted to a root folder, but not named what we expected. rename
		else
			echo "TODO"
		fi
	fi

#cp "shellcheck-${scversion}/shellcheck" /usr/bin/
#shellcheck --version

exec $SHELL