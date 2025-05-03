#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#include_guard()


############ filezilla ############
# https://filezilla-project.org/

#dk_set(FILEZILLA_EXE "$ENV{SystemDrive}\\Program Files\\FileZilla FTP Client\\filezilla.exe")

### IMPORT ###
if(NOT EXISTS ${FILEZILLA_EXE})
	dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_load				(dk_getFileParams)
	dk_getFileParams 	("$ENV{DKIMPORTS_DIR}/filezilla/dkconfig.txt")
	dk_import			(${FILEZILLA_IMPORT} NAME filezilla)
endif()
