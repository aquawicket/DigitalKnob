#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ webref ############
# https://github.com/w3c/webref.git
dk_load(dk_builder)

dk_depend(nodejs)

dk_import(https://github.com/w3c/webref/archive/48fcf557.zip PATCH)

### Build Interface Tree ###
if(Windows)
	dk_command(${NODE_EXE} ${WEBREF}/DKBuildInterfaces.js)
endif()

#dk_mkdir(${WEBREF}/DKWebAPIs)
#dk_delete(${WEBREF}/DKWebAPIs/interfaces.txt NO_HALT)
#if(NOT EXISTS ${WEBREF}/DKWebAPIs/interfaces.txt)
#	file(GLOB items RELATIVE "${WEBREF}/ed/idlnames/" "${WEBREF}/ed/idlnames/*")
#	foreach(item ${items})
#		dk_fileAppend(${WEBREF}/DKWebAPIs/interfaces.txt "${item}\n")
#	endforeach()
#endif()
