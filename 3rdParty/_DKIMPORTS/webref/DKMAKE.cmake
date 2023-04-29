# https://github.com/w3c/webref.git

dk_depend(nodejs)

dk_import(https://github.com/w3c/webref.git BRANCH curated)


### Build Interface Tree ###
dk_command(${NODE_EXE} ${WEBREF}/DKBuildInterfaces.js)

#dk_makeDirectory(${WEBREF}/DKWebAPIs)
#dk_remove(${WEBREF}/DKWebAPIs/interfaces.txt NOERROR)
#if(NOT EXISTS ${WEBREF}/DKWebAPIs/interfaces.txt)
#	file(GLOB items RELATIVE "${WEBREF}/ed/idlnames/" "${WEBREF}/ed/idlnames/*")
#	foreach(item ${items})
#		file(APPEND ${WEBREF}/DKWebAPIs/interfaces.txt "${item}\n")
#	endforeach()
#endif()