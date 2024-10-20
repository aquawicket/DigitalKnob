#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/w3c/webref.git

dk_depend(nodejs)

#dk_import(https://github.com/w3c/webref.git BRANCH curated PATCH)
dk_import(https://github.com/w3c/webref/archive/refs/heads/curated.zip PATCH)


### Build Interface Tree ###
if(WIN)
	dk_command(${NODE_EXE} ${WEBREF}/DKBuildInterfaces.js)
endif()

#dk_makeDirectory(${WEBREF}/DKWebAPIs)
#dk_delete(${WEBREF}/DKWebAPIs/interfaces.txt NO_HALT)
#if(NOT EXISTS ${WEBREF}/DKWebAPIs/interfaces.txt)
#	file(GLOB items RELATIVE "${WEBREF}/ed/idlnames/" "${WEBREF}/ed/idlnames/*")
#	foreach(item ${items})
#		dk_fileAppend(${WEBREF}/DKWebAPIs/interfaces.txt "${item}\n")
#	endforeach()
#endif()