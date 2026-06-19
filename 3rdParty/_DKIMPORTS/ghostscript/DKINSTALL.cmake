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


############ ghostscript ############
# https://github.com/ArtifexSoftware/ghostpdl-downloads
# https://silentinstallhq.com/ghostscript-silent-install-how-to-guide
# https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe

if(NOT Windows_Host)
	dk_disable(ghostscript)
	dk_return()
endif()

dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
dk_importVariables("${ghostscript_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_PATH "${DK3RDPARTY_DIR}/ghostscript-9.22")

if(NOT EXISTS ${ghostscript}/bin)
	dk_download(${ghostscript_Url})
	dk_replaceAll(${ghostscript} "/" "\\" ghostscript_WIN)
	dk_exec(${dk_download} /S /D=${ghostscript_WIN})
endif()
