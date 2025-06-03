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


dk_validate(Config_Path  "dk_Config_Path()")
# https://github.com/glfw/glfw.git
# https://www.glfw.org/docs/latest/compile.html


### DEPEND ###
#dk_depend(wayland)
#dk_depend(x11)


### IMPORT ###
dk_import(https://github.com/glfw/glfw/archive/b35641f4a3c62aa86a0b3c983d163bc0fe36026d.zip)
#dk_import(https://github.com/glfw/glfw/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${GLFW_DIR}/include								GLFW_INCLUDE_DIR)
dk_include				(${GLFW_CONFIG_DIR}/include/freetype2				GLFW_INCLUDE_DIR2)
if(MSVC)
	Windows_dk_libDebug		(${GLFW_CONFIG_DIR}/src/Debug/glfw3.lib				GLFW_LIBRARY_DEBUG)
	Windows_dk_libRelease	(${GLFW_CONFIG_DIR}/src/Release/glfw3.lib			GLFW_LIBRARY_RELEASE)
elseif(Mac)
	dk_libDebug			(${GLFW_CONFIG_DIR}/src/${Debug_Dir}/libglfw3.a		GLFW_LIBRARY_DEBUG)
	dk_libRelease		(${GLFW_CONFIG_DIR}/src/${Release_Dir}/libglfw3.a	GLFW_LIBRARY_RELEASE)
else()
	dk_libDebug			(${GLFW_CONFIG_DIR}/src/libglfw3.a					GLFW_LIBRARY_DEBUG)
	dk_libRelease		(${GLFW_CONFIG_DIR}/src/libglfw3.a					GLFW_LIBRARY_RELEASE)
endif()


## https://www.glfw.org/docs/latest/compile.html

### 3RDPARTY LINK ###
dk_set(GLFW_CMAKE -Dglfw3_DIR=${GLFW_DIR}) #-DGLFW_INCLUDE_DIR=${GLFW_INCLUDE_DIR}


	
### GENERATE ###
dk_configure(${GLFW_DIR})


### COMPILE ###
dk_build(${GLFW_DIR} glfw)
