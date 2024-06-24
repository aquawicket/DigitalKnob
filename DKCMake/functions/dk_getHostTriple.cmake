include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getHostTriple()
#
#	set the cached host variables 
#
#	<HOST> 			= WIN, APPLE, LINUX, ANDROID
#	<HOST>_HOST 	= WIN_HOST, UNIX_HOST, MAC_HOST, ANDROID_HOST
#	HOST_ARCH		= arm32, arm64, x86, x86_64

function(dk_getHostTriple)
	dk_debugFunc(${ARGV})
	
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
	
	###### Set <HOST>_HOST variables ######
	if(CMAKE_HOST_WIN32)
		dk_set(WIN_HOST 		TRUE)
	endif()
	if(CMAKE_HOST_APPLE)
		dk_set(UNIX_HOST 		TRUE)
		dk_set(MAC_HOST 		TRUE)
	endif()
	if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
		dk_set(UNIX_HOST 		TRUE)
		dk_set(LINUX_HOST 		TRUE)	
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(ANDROID_HOST TRUE)
		endif()
	endif()
	
	###### Set HOST variable ######
	if(CMAKE_HOST_WIN32)
		dk_set(HOST		WIN)
	elseif(CMAKE_HOST_APPLE)
		dk_set(HOST		APPLE)
	elseif(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(HOST	ANDROID)
		else()
			dk_set(HOST	LINUX)
		endif()
	else()
		dk_error("CMAKE_HOST: Unknown host")
	endif()
	
	### Set HOST_ARCH
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
	#dk_printVar(CMAKE_HOST_SYSTEM_PROCESSOR)
	
	if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
		dk_set(ARM64 TRUE)
		dk_set(HOST_ARCH arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
		dk_set(X86_64 TRUE)
		dk_set(HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
		dk_set(ARM64 TRUE)
		dk_set(HOST_ARCH arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
		dk_set(X86_64 TRUE)
		dk_set(HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
		dk_set(X86_64 TRUE)
		dk_set(HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
		dk_set(X86 TRUE)
		dk_set(HOST_ARCH x86)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		dk_set(X86_64 TRUE)
		dk_set(HOST_ARCH x86_64)
	else()
		dk_error("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
	endif()
	
	### set [HOST]_[HOST_ARCH] variable
	dk_toUpper(${HOST} HOST_UPPER)
	dk_toUpper(${HOST_ARCH} HOST_ARCH_UPPER)
	dk_set(${HOST_UPPER}_${HOST_ARCH_UPPER}_HOST TRUE)
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()