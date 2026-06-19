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


############ libatomic ############
if(NOT Linux AND NOT Raspberry)
	dk_disable(libatomic)
	dk_return()
endif()

### INSTALL ###
if(Linux OR Raspberry)
	#dk_installPackage(libatomic)

	### LINK ###
	#dk_include(/usr/include/atomic)
	
	#dynamic linking
	set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -latomic")
	
	#static linking
	#Raspberry_dk_lib(/usr/lib/arm-linux-gnueabihf/libatomic.a)
endif()
