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


#####################################################################
# dk_Host_Type()
#
#	  Host_Type = Windows, Unix
#
function(dk_Host_Type)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Host_Type "${ARGV0}")

	###### GET ######
	elseif(NOT DEFINED ENV{Host_Type})
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
			dk_set(Host_Type				Windows)
		elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
			dk_set(Host_Type				Windows)
		elseif(CMAKE_HOST_WIN32)
			dk_set(Host_Type				Windows)
		elseif(CMAKE_HOST_UNIX)
			dk_set(Host_Type				Unix)
		else()
			dk_fatal("CMAKE_HOST_???: Unknown host")
		endif()
	else()
		dk_set(Host_Type "$ENV{Host_Type}")
	endif()

	dk_assertVar(Host_Type)
	dk_set(${Host_Type}_Host 1)


	###### VALIDATE RESULT ######
		if(Unix_Host)
	elseif(Windows_Host)
	else()
		dk_fatal("Host_Type:'${Host_OS}' is INVALID!")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	###### GET ######
    dk_Host_Type()
	dk_printVar(Host_Type)
	dk_printVar(${Host_Type}_Host)
	
	###### SET ######
	dk_Host_Type("Unix")
	dk_printVar(Host_Type)
	dk_printVar(${Host_Type}_Host)
endfunction()