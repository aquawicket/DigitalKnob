# https://github.com/dontcallmedom/webidlpedia.git


dk_import(https://github.com/dontcallmedom/webidlpedia.git BRANCH gh-pages)


### Build WebAPIs Tree ###
dk_makeDirectory(${WEBIDLPEDIA}/DKWebAPIs)
dk_remove(${WEBIDLPEDIA}/DKWebAPIs/W3C_apis.txt NOERROR)
dk_remove(${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt NOERROR)
if(NOT EXISTS ${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt)
	file(GLOB items RELATIVE "${WEBIDLPEDIA}/names/" "${WEBIDLPEDIA}/names/*")
	foreach(item ${items})
		file(APPEND ${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt "${item}")
		file(READ ${WEBIDLPEDIA}/names/${item} filestring)
		string(FIND "${filestring}" "\">" indexA)
		string(FIND "${filestring}" "</a>" indexB)
		MATH(EXPR start "${indexA}+2")
		MATH(EXPR end "${indexB}")
		MATH(EXPR length "${end}-${start}")
		
		string(SUBSTRING "${filestring}" ${start} ${length} API)
		
		########################################################
		#set(PROCESS_API_NAMES true)
		if(${PROCESS_API_NAMES})
		########################################################
			## only " API" strings
			dk_includes("${API}" " API" includes)
			if(NOT ${includes})
				continue()
			endif()
			
			##############################
			## Web Authentication API
			dk_includes("${API}" "Web Authentication" includes)
			if(${includes})
				set(API "Web Authentication API")
			endif()
			
			## WebCodecs API
			dk_includes("${API}" "WebCodecs" includes)
			if(${includes})
				set(API "WebCodecs API")
			endif()
			
			## WebGL
			dk_includes("${API}" "WebGL" includes)
			if(${includes})
				set(API "WebGL")
			endif()
			
			## WebRTC
			dk_includes("${API}" "WebRTC" includes)
			if(${includes})
				set(API "WebRTC")
			endif()
			
			## WebXR Device API
			dk_includes("${API}" "WebXR" includes)
			if(${includes})
				set(API "WebXR Device API")
			endif()
			
			## XMLHttpRequest
			dk_includes("${API}" "XMLHttpRequest" includes)
			if(${includes})
				set(API "XMLHttpRequest")
			endif()
		########################################################
		endif()
		########################################################
		
		dk_includes("${APIS}" "${API}" includes)
		if(${includes})
		
		else()
			dk_set(APIS "${APIS};${API}")
			file(APPEND ${WEBIDLPEDIA}/DKWebAPIs/W3C_apis.txt "${API}\n")
		endif()
		
		file(APPEND ${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt " - ${API}\n")
	endforeach()
endif()
