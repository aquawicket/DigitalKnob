include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/w3c/webref.git

dk_depend(nodejs)

dk_import(https://github.com/w3c/webref.git BRANCH curated PATCH)


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