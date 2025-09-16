#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ doxygen ############
# https://github.com/doxygen/doxygen.git
# https://sourceforge.net/projects/doxygen
# FIXME:  Install to /3rdParty only
dk_validate(Target_Config  "dk_Target_Config()")

if(NOT Windows_Host)
	dk_disable(doxygen)
	dk_return()
endif()

### IMPORT ###
if(Windows_Host)
	dk_set(DOXYGEN_EXE "${ProgramFiles}/doxygen/bin/doxygen.exe")
else()
	dk_set(DOXYGEN_EXE "/Applications/Doxygen.app") #FIXME
endif()


if(NOT EXISTS ${DOXYGEN_EXE})
	if(Windows_Host)
		dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6-setup.exe)
		dk_exec($ENV{DKDOWNLOAD_DIR}/doxygen-1.9.6-setup.exe)
	elseif(Mac_Host)
		dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/Doxygen-1.9.6.dmg) #FIXME:  The Downloaded file is a BYPASS file .dmg
		dk_exec($ENV{DKDOWNLOAD_DIR}/Doxygen-1.9.6.dmg)
	else()
		dk_import(https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6.linux.bin.tar.gz)
		#dk_exec($ENV{DKDOWNLOAD_DIR}/doxygen-1.9.6.linux.bin.tar.gz) #FIXME
	endif()
endif()
