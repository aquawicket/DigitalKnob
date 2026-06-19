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


############ libxinerama-dev ############

if(NOT Linux AND NOT Raspberry)
	dk_disable(libxinerama-dev)
	dk_return()
endif()

#if(EXISTS /usr/include/X11)
#	dk_include(/usr/include/X11)
#elseif(EXISTS /usr/local/include/X11)
#	dk_include(/usr/local/include/X11)
#else()
	if(TINYCORE)
		#dk_exec(tce-load -wi libXinerama-dev.tcz)
		dk_installPackage(libXinerama-dev.tcz)
	else()
		dk_installPackage(libxinerama-dev)
	endif()
#endif()

#dynamic linking
set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXinerama")
