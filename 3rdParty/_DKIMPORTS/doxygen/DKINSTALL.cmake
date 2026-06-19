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


############ doxygen ############
# https://github.com/doxygen/doxygen.git
# https://sourceforge.net/projects/doxygen
# https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6-setup.exe
# https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/Doxygen-1.9.6.dmg
# https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6.linux.bin.tar.gz

if(NOT Windows_Host)
	dk_disable(doxygen)
	dk_return()
endif()

if(Windows_Host)
	dk_set(doxygen_exe "${ProgramFiles}/doxygen/bin/doxygen.exe")
else()
	dk_set(doxygen_exe "/Applications/Doxygen.app") #FIXME
endif()

if(NOT EXISTS ${doxygen_exe})
	dk_import(${doxygen_${Host_Os}_Import})
	
	if(Mac_Host)
		#FIXME:  The Downloaded file is a BYPASS file .dmg
		dk_exec(${DKDOWNLOAD_DIR}/Doxygen-1.9.6.dmg)
	elseif(Windows_Host)
		dk_exec(${DKDOWNLOAD_DIR}/doxygen-1.9.6-setup.exe)
	elseif(Linux_Host)
		#dk_exec(${DKDOWNLOAD_DIR}/doxygen-1.9.6.linux.bin.tar.gz) #FIXME
	endif()
endif()
