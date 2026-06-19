#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ winscp ############
# https://winscp.net/eng/index.php
# https://winscp.net/download/WinSCP-6.5.3-Portable.zip/download
# https://cdn.winscp.net/files/WinSCP-6.5.3-Portable.zip?secure=6OnlXQ4QRsKhmoH-6rdppw==,1760749223

#dk_import()
dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_download("${winscp_Import}" "${DKDOWNLOAD_DIR}/WinSCP-6.5.1-Portable.zip")
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_smartExtract("${dk_download}" "${DKTOOLS_DIR}/WinSCP-6.5.1-Portable")
