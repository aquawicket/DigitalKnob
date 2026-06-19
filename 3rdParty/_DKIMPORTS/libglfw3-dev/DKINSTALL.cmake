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


########### libglfw3-dev ###########
if(NOT UNIX_HOST)
	dk_disable(libglfw3-dev)
	dk_return()
endif()

### INSTALL ###
if(Linux)
	dk_installPackage(libglfw3-dev)
endif()
if(Mac)
	#dk_exec(brew install glfw3)
	dk_installPackage(glfw3)
	dk_include(/usr/local/include)
	dk_lib(/usr/local/lib/libglfw.3.3.dylib)
endif()
