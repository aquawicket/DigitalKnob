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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKEmscripten ############
## https://emscripten.org/docs/getting_started/downloads.html

dk_depend(emsdk)

##dk_generateCmake(DKEmscripten)
##dk_assets(DKEmscripten)

dk_chdir(${DKCPP_PLUGINS_DIR}/DKEmscripten)
#if(Windows_X86)
#	dk_exec(${EMSCRIPTEN}/emscripten/1.37.33/emcc ${DKCPP_PLUGINS_DIR}/DKEmscripten/hello.c -o hello.html)
#endif()

if(EXISTS ${EMSCRIPTEN}/emscripten/1.37.33/emcc)
	if(Windows_X86)
		dk_exec(${EMSCRIPTEN}/emscripten/1.37.33/emcc --bind -o test.js ${DKCPP_PLUGINS_DIR}/DKEmscripten/test.cpp)
	endif()
endif()