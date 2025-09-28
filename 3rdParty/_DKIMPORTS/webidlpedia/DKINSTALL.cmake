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


############ webidlpedia ############
# https://github.com/dontcallmedom/webidlpedia.git
# https://github.com/dontcallmedom/webidlpedia/archive/refs/heads/gh-pages.zip
# https://github.com/dontcallmedom/webidlpedia/archive/398a36b0.zip

dk_import()

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
