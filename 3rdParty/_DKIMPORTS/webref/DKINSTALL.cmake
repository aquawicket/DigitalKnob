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


############ webref ############
# https://github.com/w3c/webref.git
# https://github.com/w3c/webref/archive/48fcf557.zip

dk_depend(nodejs)

#dk_import(https://github.com/w3c/webref/archive/48fcf557.zip PATCH)
dk_import()

### Build Interface Tree ###
if(Windows)
	dk_exec(${node_exe} ${WEBREF}/DKBuildInterfaces.js)
endif()

#dk_mkdir(${WEBREF}/DKWebAPIs)
#dk_delete(${WEBREF}/DKWebAPIs/interfaces.txt NO_HALT)
#if(NOT EXISTS ${WEBREF}/DKWebAPIs/interfaces.txt)
#	file(GLOB items RELATIVE "${WEBREF}/ed/idlnames/" "${WEBREF}/ed/idlnames/*")
#	foreach(item ${items})
#		dk_fileAppend(${WEBREF}/DKWebAPIs/interfaces.txt "${item}\n")
#	endforeach()
#endif()
