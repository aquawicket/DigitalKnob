#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_host_triple()
#
#	set the cached host variables 
#
#	HOST_OS 				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	HOST_ARCH				= ARM32, ARM64, X86, X86_64
#	HOST_ENV				= CLANG, MINGW, MSVC, UCRT
#	<OS>_HOST 				= ANDROID_HOST, EMSCRIPTEN_HOST, IOS_HOST, IOSSIM_HOST, LINUX_HOST, MAC_HOST, RASPBERRY_HOST, WINDOWS_HOST 
#   <OS>_<ARCH>_HOST		= ANDROID_ARM64_HOST, EMSCRIPTEN_ARM64_HOST, IOS_ARM64_HOST, IOSSIM_ARM64_HOST, LINUX_ARM64_HOST, MAC_ARM64_HOST, RASPBERRY_ARM64_HOST, WINDOWS_ARM64_HOST 
#   <OS>_<ARCH>_<ENV>_HOST	= ANDROID_ARM64_CLANG_HOST, EMSCRIPTEN_ARM64_CLANG_HOST, IOS_ARM64_CLANG_HOST, IOSSIM_ARM64_CLANG_HOST, LINUX_ARM64_CLANG_HOST, MAC_ARM64_CLANG_HOST, RASPBERRY_ARM64_CLANG_HOST, WINDOWS_ARM64_CLANG_HOST 
#
function(dk_host_triple)
	dk_debugFunc()

#:: NOTICE: default environment moved to dk_target_triple()
#	#### DEFAULT HOST ENVIRONMENT ###
#	if(DEFINED ENV{HOST_ENV})
#		dk_set(default_host_env $ENV{HOST_ENV})
#		dk_set(HOST_ENV $ENV{HOST_ENV})
#	endif()

#	dk_printVar(CMAKE_HOST_SYSTEM_NAME)
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
	
	###### Set host_os / HOST_OS, <OS>_HOST ######
	if(CMAKE_HOST_WIN32)
		dk_set(HOST_OS				WIN)
	elseif(CMAKE_HOST_UNIX)
		dk_set(HOST_OS				UNIX)
		dk_set(UNIX_HOST	    	1)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(HOST_OS 			ANDROID)
		elseif(CMAKE_HOST_APPLE)
			dk_set(HOST_OS			MAC)
			dk_set(APPLE_HOST		1)
		else()
			dk_set(HOST_OS 			LINUX)
		endif()
	else()
		dk_fatal("CMAKE_HOST: Unknown host")
	endif()
	dk_assertVar(HOST_OS)
	dk_set($ENV{HOST_OS}_HOST 1)
	dk_set(HOST_TRIPLE "$ENV{HOST_OS}")
	dk_set($ENV{HOST_TRIPLE}_HOST 1)
	dk_printVar(HOST_OS)				#     HOST_OS = WIN
	dk_printVar($ENV{HOST_OS}_HOST)		#    WIN_HOST = 1
	dk_printVar(HOST_TRIPLE)			# HOST_TRIPLE = WIN
	dk_printVar($ENV{HOST_TRIPLE}_HOST)	#    WIN_HOST = 1
	
	### Set host_arch/HOST_ARCH
	if(NOT CMAKE_HOST_SYSTEM_PROCESSOR)
		if(CMAKE_HOST_WIN32)
			if (DEFINED ENV{PROCESSOR_ARCHITEW6432})
			  set(CMAKE_HOST_SYSTEM_PROCESSOR "$ENV{PROCESSOR_ARCHITEW6432}")
			else()
			  set(CMAKE_HOST_SYSTEM_PROCESSOR "$ENV{PROCESSOR_ARCHITECTURE}")
			endif()
		else()
			execute_process(COMMAND uname -m OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_PROCESSOR)
		endif()
	endif()
	string(STRIP "${CMAKE_HOST_SYSTEM_PROCESSOR}" CMAKE_HOST_SYSTEM_PROCESSOR)
	if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
		dk_set(HOST_ARCH ARM64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
		dk_set(HOST_ARCH X86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
		dk_set(HOST_ARCH ARM64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
		dk_set(HOST_ARCH X86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
		dk_set(HOST_ARCH X86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
		dk_set(HOST_ARCH X86)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		dk_set(HOST_ARCH X86_64)
	else()
		dk_fatal("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
	endif()
	if(DEFINED ENV{HOST_ARCH})
		dk_set($ENV{HOST_ARCH}_HOST 1)
		dk_set(HOST_TRIPLE "$ENV{HOST_TRIPLE}_$ENV{HOST_ARCH}")
		dk_set($ENV{HOST_TRIPLE}_HOST 1)
		dk_printVar(HOST_ARCH)						#       HOST_ARCH = X86_64
		dk_printVar($ENV{HOST_ARCH}_HOST)			#     X86_64_HOST = 1
		dk_printVar(HOST_TRIPLE)					#     HOST_TRIPLE = WIN_X86_64
		dk_printVar($ENV{HOST_TRIPLE}_HOST)		    # WIN_X86_64_HOST = 1
	endif()
	
	
	###### HOST_ENV ######
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
		dk_set(HOST_ENV 	"MSYS")
	elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
		dk_set(HOST_ENV 	"MINGW")
	elseif(MSVC)
		dk_set(HOST_ENV 	"MSVC")
	else()
		dk_set(HOST_ENV 	"${DEFAULT_HOST_ENV}")
		dk_set(HOST_ENV 	"TEST")
	endif()
	if(DEFINED ENV{HOST_ENV})
		dk_set($ENV{HOST_ENV}_HOST 1)
		dk_set(HOST_TRIPLE "$ENV{HOST_TRIPLE}_$ENV{HOST_ENV}")
		dk_set($ENV{HOST_TRIPLE}_HOST 1)
		dk_printVar(HOST_ENV)					#              HOST_ENV = MSVC
		dk_printVar($ENV{HOST_ENV}_HOST)		#             MSVC_HOST = 1
		dk_printVar(HOST_TRIPLE)				#           HOST_TRIPLE = WIN_X86_64_MSVC
		dk_printVar($ENV{HOST_TRIPLE}_HOST)		#  WIN_X86_64_MSVC_HOST = 1	
	endif()

endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_host_triple()
endfunction()
