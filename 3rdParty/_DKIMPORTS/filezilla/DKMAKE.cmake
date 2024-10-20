#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ filezilla ############
# https://filezilla-project.org/

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam 	("${DKIMPORTS_DIR}/filezilla/filezilla.txt" FILEZILLA_DL)
dk_import			(${FILEZILLA_DL})
