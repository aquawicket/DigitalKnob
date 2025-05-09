#!/usr/bin/cmake -P
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
	if(ARGV0)
		dk_set(Host_Os "${ARGV0}")

	###### GET ######	
	else()
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
		
		###### Set host_os / HOST_OS, <os>_host / <OS>_HOST ######
		if(CMAKE_HOST_WIN32)
			dk_set(Host_Os				Win)
		elseif(CMAKE_HOST_UNIX)
			dk_set(Unix_Host 			1)
			if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
				dk_set(Host_Os 			Android)
			elseif(CMAKE_HOST_APPLE)
				dk_set(Host_Os			Mac)
				dk_set(Apple_Host		1)
			else()
				dk_set(Host_Os 			Linux)
			endif()
		else()
			dk_fatal("CMAKE_HOST_???: Unknown host")
		endif()
	endif()

	dk_assertVar(Host_Os)
	dk_printVar(Host_Os)				# Host_Os = "Win"
	
	dk_set(${Host_Os}_Host 1)				
	dk_printVar(${Host_Os}_Host)		# Win_Host = 1
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