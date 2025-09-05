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


###### glfw ######
# https://github.com/glfw/glfw.git
# https://www.glfw.org/docs/latest/compile.html


### DEPEND ###
#dk_depend(wayland)
#dk_depend(x11)

### IMPORT ###
dk_import()

### LINK ###
dk_include					(${glfw}/include									GLFW_INCLUDE_DIR)
dk_include					(${glfw_Config_Dir}/include/freetype2				GLFW_INCLUDE_DIR2)
if(MSVC)
	Windows_dk_libDebug		(${glfw_Config_Dir}/src/Debug/glfw3.lib				GLFW_LIBRARY_DEBUG		GLFW_LIBRARY)
	Windows_dk_libRelease	(${glfw_Config_Dir}/src/Release/glfw3.lib			GLFW_LIBRARY_RELEASE	GLFW_LIBRARY)
elseif(Mac)
	dk_libDebug				(${glfw_Config_Dir}/src/${Debug_Dir}/libglfw3.a		GLFW_LIBRARY_DEBUG		GLFW_LIBRARY)
	dk_libRelease			(${glfw_Config_Dir}/src/${Release_Dir}/libglfw3.a	GLFW_LIBRARY_RELEASE	GLFW_LIBRARY)
else()
	dk_libDebug				(${glfw_Config_Dir}/src/libglfw3.a					GLFW_LIBRARY_DEBUG		GLFW_LIBRARY)
	dk_libRelease			(${glfw_Config_Dir}/src/libglfw3.a					GLFW_LIBRARY_RELEASE	GLFW_LIBRARY)
endif()

## https://www.glfw.org/docs/latest/compile.html
### 3RDPARTY LINK ###
dk_set(glfw_CMAKE -Dglfw3_DIR=${glfw}) #-DGLFW_INCLUDE_DIR=${GLFW_INCLUDE_DIR}

### GENERATE ###
dk_configure()

### COMPILE ###
dk_build(${glfw} glfw)
