#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


#####################################################################
# dk_Host_Os()
#
#	  Host_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#
function(dk_Host_Os)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Host_Os "${ARGV0}")

	###### GET ######
	elseif(NOT DEFINED ENV{Host_Os})
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
			set(CMAKE_HOST_WIN32 1)
			dk_unset(CMAKE_HOST_UNIX)
			dk_unset(CMAKE_HOST_APPLE)
		endif()
			
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
			set(CMAKE_HOST_WIN32 1)
			dk_unset(CMAKE_HOST_UNIX)
			dk_unset(CMAKE_HOST_APPLE)
		endif()
			
		###### Set Host_Os and <Os>_Host ######
		if(CMAKE_HOST_WIN32)
			dk_set(Host_Os				Windows)
		elseif(CMAKE_HOST_UNIX)
			dk_set(Unix_Host 			1)
			if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
				dk_set(Host_Os 			Android)
			elseif(CMAKE_HOST_APPLE)
				dk_set(Apple_Host		1)
				dk_set(Host_Os			Mac)
			else()
				dk_set(Host_Os 			Linux)
			endif()
		else()
			dk_fatal("CMAKE_HOST_???: Unknown host")
		endif()
	else()
		dk_set(Host_Os "$ENV{Host_Os}")
	endif()

	dk_assertVar(Host_Os)
	dk_set(${Host_Os}_Host 1)


	###### VALIDATE RESULT ######
		if(Android_Host)
	elseif(Emscripten_Host)
	elseif(Ios_Host)
	elseif(Iossim_Host)
	elseif(Linux_Host)
	elseif(Mac_Host)
	elseif(Raspberry_Host)
	elseif(Windows_Host)
	else()
		dk_fatal("Host_OS:'${Host_OS}' is INVALID!")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	###### GET ######
    dk_Host_Os()
	dk_printVar(Host_Os)
	dk_printVar(${Host_Os}_Host)
	
	###### SET ######
	dk_Host_Os("Windows")
	dk_printVar(Host_Os)
	dk_printVar(${Host_Os}_Host)
endfunction()