#!/bin/bash
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh


##################################################################################
# DKINSTALL()
#
#
DKINSTALL() {
#	dk_debugFunc 0

	dk_call dk_getFileParams "$(dk_call dk_dirname ${BASH_SOURCE[0]})/dkconfig.txt"
	echo "cmake_Linux_X86_64_Import = ${cmake_Linux_X86_64_Import}"
	
	dk_call dk_validate Host_Tuple "dk_Host_Tuple"
	cmake_ImportA="cmake_${Host_Tuple}_Import"
	cmake_Import="${cmake_ImportA}"  # for unknown reasons variable indirection isn't working on WSL here.  aka. ${!variable}
	echo "cmake_Import = ${cmake_Import}"
	
	echo "Target_Tuple = ${Target_Tuple}"
	[ -n "${Linux_X86_64}" ] && cmake_Import="${cmake_Linux_X86_64_Import}"
	
	dk_call dk_assertVar cmake_Import

	if dk_call dk_isUrl "${cmake_Import}"; then
		dk_call dk_info "Installing CMake from direct download"
		
		dk_call dk_basename "${cmake_Import}" cmake_Import_FILE
		dk_call dk_removeExtension "${cmake_Import_FILE}" CMAKE_FOLDER
		#dk_call dk_convertToCIdentifier "${CMAKE_FOLDER}" CMAKE_FOLDER
		dk_call dk_toLower "${CMAKE_FOLDER}" CMAKE_FOLDER
		
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		[ "${Host_Os}" = "Windows" ]   && export CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe
		[ "${Host_Os}" = "Mac" ]       && export CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/CMake.app/Contents/bin/cmake
		[ "${Host_Os}" = "Linux" ]     && export CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake
		[ "${Host_Os}" = "Raspberry" ] && export CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake
		[ -z ${CMAKE_EXE} ]            && dk_call dk_error "no cmake for this OS"
		dk_call dk_printVar CMAKE_EXE
		
		dk_call dk_pathExists "${CMAKE_EXE}" && return $(true)

		dk_call dk_echo
		dk_call dk_info "Installing cmake . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download "${cmake_Import}" "${DKDOWNLOAD_DIR}"/"${cmake_Import_FILE}"
		#dk_call dk_extract "${DKDOWNLOAD_DIR}"/"${cmake_Import_FILE}" "${DKTOOLS_DIR}"
		#dk_call dk_removeExtension ${cmake_Import_NAME} cmake_Import_NAME
		#dk_call dk_rename "${DKTOOLS_DIR}/${cmake_Import_NAME}" "${CMAKE_FOLDER}"
		#echo ${CMAKE_FOLDER}>"${DKTOOLS_DIR}\${CMAKE_FOLDER}\installed"
		dk_call dk_smartExtract "${DKDOWNLOAD_DIR}"/"${cmake_Import_FILE}" "${DKTOOLS_DIR}"
		dk_call dk_pathExists "${CMAKE_EXE}" || dk_call dk_error "cannot find cmake.exe"; return -1

	else	# Linux package
		dk_call dk_info "Installing CMake from package managers"
		
		$(command -v cmake) && CMAKE_EXE=$(command -v cmake)
		dk_call dk_realpath ${CMAKE_EXE} CMAKE_EXE
		dk_call dk_printVar CMAKE_EXE
		if ! dk_call dk_commandExists cmake; then
			dk_call dk_installPackage ${cmake_Import}
		fi	
		CMAKE_EXE=$(command -v cmake)
		dk_call dk_realpath ${CMAKE_EXE} CMAKE_EXE
		dk_call dk_printVar CMAKE_EXE
	fi
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
#	dk_debugFunc 0
	
	DKINSTALL
}