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
# dk_Host_Env()
#
#	  Host_Env = 
#
function(dk_Host_Env)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Host_Env "${ARGV0}")	#  Host_Env = MyEnv	

	###### GET ######	
	elseif(NOT DEFINED ENV{Host_Env})
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
			dk_set(Host_Env 	"Msys")
		elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
			dk_set(Host_Env 	"MinGW")
		elseif(MSVC)
			dk_set(Host_Env 	"Msvc")
		else()
			dk_set(Host_Env 	"${CMAKE_HOST_SYSTEM_NAME}")
		endif()
		dk_assertVar(Host_Env)		#  Host_Env = Msys
	else()
		dk_set(Host_Env "$ENV{Host_Env}")
	endif()
	dk_set(${Host_Env}_Host 1)		# Msys_Host = 1


	###### VALIDATE RESULT ######
		if(Android_Host)
	elseif(Linux_Host)
	elseif(Mac_Host)
	elseif(MinGW_Host)
	elseif(Msvc_Host)
	elseif(Msys_Host)
	elseif(Raspberry_Host)
	elseif(Windows_Host)
	else()
		dk_fatal("Host_Env:'${Host_Env}' is INVALID!")
	endif()	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	###### GET ######
    dk_Host_Env()
	dk_printVar(Host_Env)
	dk_printVar(${Host_Env}_Host)
	
	###### SET ######
	dk_Host_Env("MyEnv")
	dk_printVar(Host_Env)
	dk_printVar(${Host_Env}_Host)
endfunction()