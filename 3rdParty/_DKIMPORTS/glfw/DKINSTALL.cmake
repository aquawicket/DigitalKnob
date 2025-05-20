#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
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
	dk_libDebug			(${GLFW_CONFIG_DIR}/src/${DEBUG_DIR}/libglfw3.a		GLFW_LIBRARY_DEBUG)
	dk_libRelease		(${GLFW_CONFIG_DIR}/src/${RELEASE_DIR}/libglfw3.a	GLFW_LIBRARY_RELEASE)
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
