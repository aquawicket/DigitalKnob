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
# dk_Host_Arch()
#
#	  Host_Arch = Arm32, Arm64, X86, X86_64, Cosmopolitan
#
function(dk_Host_Arch)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Host_Arch "${ARGV0}")
	
	###### GET ######
	elseif(NOT DEFINED ENV{Host_Arch})
		### Set Host_Arch ###
		if(NOT CMAKE_HOST_SYSTEM_PROCESSOR)
			if(CMAKE_HOST_WIN32)
				if (DEFINED ENV{PROCESSOR_ARCHITEW6432})
					dk_set(CMAKE_HOST_SYSTEM_PROCESSOR "$ENV{PROCESSOR_ARCHITEW6432}")
				else()
					dk_set(CMAKE_HOST_SYSTEM_PROCESSOR "$ENV{PROCESSOR_ARCHITECTURE}")
				endif()
			else()
				execute_process(COMMAND uname -m OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_PROCESSOR)
			endif()
		endif()
		string(STRIP "${CMAKE_HOST_SYSTEM_PROCESSOR}" CMAKE_HOST_SYSTEM_PROCESSOR)
		#if(Cosmopolitan)
		#	dk_set(Host_Arch Cosmopolitan)
		if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
			dk_set(Host_Arch Arm64)
		elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
			dk_set(Host_Arch X86_64)
		elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
			dk_set(Host_Arch Arm64)
		elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
			dk_set(Host_Arch X86_64)
		elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
			dk_set(Host_Arch X86_64)
		elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
			dk_set(Host_Arch X86)
		elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
			dk_set(Host_Arch X86_64)
		else()
			dk_fatal("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
		endif()
	else()
		dk_set(Host_Arch "$ENV{Host_Arch}")
	endif()	
	dk_assertVar(Host_Arch)			#  Host_Arch = Arm64
	dk_set(${Host_Arch}_Host 1)		# Arm64_Host = 1
	
	
	###### VALIDATE RESULT ######
		if(Arm32_Host)
	elseif(Arm64_Host)
	elseif(X86_Host)
	elseif(X86_64_Host)
	elseif(Cosmo_Host)
	else()
		dk_fatal("Host_Arch:'${Host_Arch}' is INVALID!")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	###### GET ######
    dk_Host_Arch()
	dk_printVar(Host_Arch)
	dk_printVar(${Host_Arch}_Host)
	
	###### SET ######
	dk_Host_Arch("I686")
	dk_printVar(Host_Arch)
	dk_printVar(${Host_Arch}_Host)
endfunction()