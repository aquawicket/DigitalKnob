#!/usr/bin/cmake -P
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
	if(ARGV0)
		dk_set(Host_Env "${ARGV0}")	#  Host_Env = MyEnv	

	###### GET ######	
	else()
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
			dk_set(Host_Env 	"Msys")
		elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
			dk_set(Host_Env 	"MinGw")
		elseif(MSVC)
			dk_set(Host_Env 	"Msvc")
		else()
			dk_set(Host_Env 	"${CMAKE_HOST_SYSTEM_NAME}")
		endif()
		dk_assertVar(Host_Env)		#  Host_Env = Msys		
	endif()
	dk_set(${Host_Env}_Host 1)		# Msys_Host = 1		
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