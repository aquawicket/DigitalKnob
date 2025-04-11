#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ webidlpedia ############
# https://github.com/dontcallmedom/webidlpedia.git
dk_load(dk_builder)

#dk_import(https://github.com/dontcallmedom/webidlpedia/archive/refs/heads/gh-pages.zip)
dk_import(https://github.com/dontcallmedom/webidlpedia/archive/398a36b0.zip)

### Build WebAPIs Tree ###
dk_mkdir(${WEBIDLPEDIA}/DKWebAPIs)
dk_delete(${WEBIDLPEDIA}/DKWebAPIs/W3C_apis.txt NO_HALT)
dk_delete(${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt NO_HALT)
if(NOT EXISTS ${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt)
	file(GLOB items RELATIVE "${WEBIDLPEDIA}/names/" "${WEBIDLPEDIA}/names/*")
	foreach(item ${items})
		dk_fileAppend(${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt "${item}")
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
			if(NOT API MATCHES " API")
				continue()
			endif()
			
			##############################
			## Web Authentication API
			if(API MATCHES "Web Authentication")
				set(API "Web Authentication API")
			endif()
			
			## WebCodecs API
			if(API MATCHES "WebCodecs")
				set(API "WebCodecs API")
			endif()
			
			## WebGL
			if(API MATCHES  "WebGL")
				set(API "WebGL")
			endif()
			
			## WebRTC
			if(API MATCHES "WebRTC")
				set(API "WebRTC")
			endif()
			
			## WebXR Device API
			if(API MATCHES "WebXR")
				set(API "WebXR Device API")
			endif()
			
			## XMLHttpRequest
			if(API MATCHES "XMLHttpRequest")
				set(API "XMLHttpRequest")
			endif()
		########################################################
		endif()
		########################################################
		
		if(APIS MATCHES "${API}")
		
		else()
			dk_set(APIS "${APIS};${API}")
			dk_fileAppend(${WEBIDLPEDIA}/DKWebAPIs/W3C_apis.txt "${API}\n")
		endif()
		
		dk_fileAppend(${WEBIDLPEDIA}/DKWebAPIs/W3C_interfaces.txt " - ${API}\n")
	endforeach()
endif()
