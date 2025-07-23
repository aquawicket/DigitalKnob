#/usr/bin/cmake -P
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


###### emscripten-targz ######
# https://github.com/mmore500/emscripten-targz/archive/da05a1a87a8327747bf812533e9040a0a2593967.zip

### INSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${EMSCRIPTEN-TARGZ_IMPORT})
dk_copy				("${CMAKE_CURRENT_LIST_DIR}/RUN.cmd" "${EMSCRIPTEN-TARGZ}/RUN.cmd" OVERWRITE)
