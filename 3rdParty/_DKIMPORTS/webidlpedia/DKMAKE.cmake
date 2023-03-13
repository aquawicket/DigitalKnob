# https://github.com/dontcallmedom/webidlpedia.git


dk_import(https://github.com/dontcallmedom/webidlpedia.git BRANCH gh-pages)


### Build WebAPIs Tree ###
dk_makeDirectory(${WEBIDLPEDIA}/DKWebAPIs)
dk_remove(${WEBIDLPEDIA}/DKWebAPIs/apis.txt NOERROR)
dk_remove(${WEBIDLPEDIA}/DKWebAPIs/interfaces.txt NOERROR)
if(NOT EXISTS ${WEBIDLPEDIA}/DKWebAPIs/interfaces.txt)
	file(GLOB items RELATIVE "${WEBIDLPEDIA}/names/" "${WEBIDLPEDIA}/names/*")
	foreach(item ${items})
		file(APPEND ${WEBIDLPEDIA}/DKWebAPIs/interfaces.txt "${item}")
		file(READ ${WEBIDLPEDIA}/names/${item} filestring)
		string(FIND "${filestring}" "\">" indexA)
		string(FIND "${filestring}" "</a>" indexB)
		MATH(EXPR start "${indexA}+2")
		MATH(EXPR end "${indexB}")
		MATH(EXPR length "${end}-${start}")
		
		string(SUBSTRING "${filestring}" ${start} ${length} API)
		
		## WebGL API
		dk_includes("${API}" "WebGL" includes)
		if(${includes})
			set(API "WebGL API")
		endif()
		
		## WebRTC API
		dk_includes("${API}" "WebRTC" includes)
		if(${includes})
			set(API "WebRTC API")
		endif()
		
		## WebXR Device API
		dk_includes("${API}" "WebXR " includes)
		if(${includes})
			set(API "WebXR Device API")
		endif()
		
		dk_includes("${APIS}" "${API}" includes)
		if(${includes})
		
		else()
			dk_set(APIS "${APIS};${API}")
			file(APPEND ${WEBIDLPEDIA}/DKWebAPIs/apis.txt "${API}\n")
		endif()
		
		file(APPEND ${WEBIDLPEDIA}/DKWebAPIs/interfaces.txt " - ${API}\n")
	endforeach()
endif()
