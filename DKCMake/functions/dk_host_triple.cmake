#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_host_triple()
#
#	set the cached host variables 
#
#	host_os 				= android, emscripten, ios, iossim, linux, mac, raspberry, windows
#	HOST_OS 				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	host_arch				= arm32, arm64, x86, x86_64
#	HOST_ARCH				= ARM32, ARM64, X86, X86_64
#	host_env				= clang, mingw, msvc, ucrt
#	HOST_ENV				= CLANG, MINGW, MSVC, UCRT
#	<os>_host 				= android_host, emscripten_host, ios_host, iossim_host, linux_host, mac_host, raspberry_host, windows_host 
#	<OS>_HOST 				= ANDROID_HOST, EMSCRIPTEN_HOST, IOS_HOST, IOSSIM_HOST, LINUX_HOST, MAC_HOST, RASPBERRY_HOST, WINDOWS_HOST 
#   <os>_<arch>_host		= android_arm64_host, emscripten_arm64_host, ios_arm64_host, iossim_arm64_host, linux_arm64_host, mac_arm64_host, raspberry_arm64_host, windows_arm64_host
#   <OS>_<ARCH>_HOST		= ANDROID_ARM64_HOST, EMSCRIPTEN_ARM64_HOST, IOS_ARM64_HOST, IOSSIM_ARM64_HOST, LINUX_ARM64_HOST, MAC_ARM64_HOST, RASPBERRY_ARM64_HOST, WINDOWS_ARM64_HOST 
#   <OS>_<ARCH>_<ENV>_HOST	= ANDROID_ARM64_CLANG_HOST, EMSCRIPTEN_ARM64_CLANG_HOST, IOS_ARM64_CLANG_HOST, IOSSIM_ARM64_CLANG_HOST, LINUX_ARM64_CLANG_HOST, MAC_ARM64_CLANG_HOST, RASPBERRY_ARM64_CLANG_HOST, WINDOWS_ARM64_CLANG_HOST 
#
function(dk_host_triple)
	dk_debugFunc("\${ARGV}")
	
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
		dk_set(host_os				win)
	elseif(CMAKE_HOST_UNIX)
		dk_set(unix_host 			1)
		dk_set(UNIX_HOST	    	1)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(host_os 			android)
		elseif(CMAKE_HOST_APPLE)
			dk_set(host_os			mac)
			dk_set(apple_host		1)
			dk_set(APPLE_HOST		1)
		else()
			dk_set(host_os 			linux)
		endif()
	else()
		dk_fatal("CMAKE_HOST: Unknown host")
	endif()
	dk_assert(host_os)
	dk_set(${host_os}_host 1)			# win_host = 1
	dk_toUpper(${host_os} HOST_OS)      # HOST_OS = WIN
	dk_set(HOST_OS ${HOST_OS})
	dk_set(${HOST_OS}_HOST 1)			# WIN_HOST = 1
	dk_printVar(host_os)
	dk_printVar(HOST_OS)
	dk_printVar(${host_os}_host)
	dk_printVar(${HOST_OS}_HOST)
	
	
	### Set host_arch/HOST_ARCH
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
	if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
		dk_set(host_arch arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
		dk_set(host_arch x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
		dk_set(host_arch arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
		dk_set(host_arch x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
		dk_set(host_arch x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
		dk_set(host_arch x86)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		dk_set(host_arch x86_64)
	else()
		dk_fatal("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
	endif()
	dk_assert(host_arch)
	dk_set(${host_arch}_host 1)				# arm64_host = 1
	dk_toUpper(${host_arch} HOST_ARCH)      # HOST_ARCH = ARM64
	dk_set(HOST_ARCH ${HOST_ARCH})
	dk_set(${HOST_ARCH}_HOST 1)				# ARM64_HOST = 1
	dk_printVar(host_arch)
	dk_printVar(HOST_ARCH)
	dk_printVar(${host_arch}_host)
	dk_printVar(${HOST_ARCH}_HOST)
	
	
	#### Set Default host_env, HOST_ENV ###
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
		dk_set(host_env 	"clang")
	elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
		dk_set(host_env 	"clang")
	elseif(MSVC)
		dk_set(host_env 	"msvc")
	else()
		dk_set(host_env 	"clang")
	endif()
	#dk_assert(host_env)
	if(host_env)
		dk_set(${host_env}_host 1)				# msvc_host = 1
		dk_toUpper(${host_env} HOST_ENV)		# HOST_ENV = MSVC
		dk_set(HOST_ENV ${HOST_ENV})
		dk_set(${HOST_ENV}_HOST 1)				# MSVC_HOST = 1
		dk_printVar(host_env)
		dk_printVar(HOST_ENV)
		dk_printVar(${host_env}_host)
		dk_printVar(${HOST_ENV}_HOST)
	endif()
	
	
	### set HOST_TRIPLE ###
	if(host_arch)
		dk_set(HOST_TRIPLE "${host_os}_${host_arch}")
		dk_set(HOST_TRIPLE "${HOST_OS}_${HOST_ARCH}")
		dk_set(${HOST_TRIPLE}_host 1)	
		dk_set(${HOST_TRIPLE}_HOST 1)
		dk_printVar(${HOST_TRIPLE}_host)
		dk_printVar(${HOST_TRIPLE}_HOST)
	endif()
	if(host_env)
		dk_set(HOST_TRIPLE "${host_os}_${host_arch}_${host_env}")
		dk_set(HOST_TRIPLE "${HOST_OS}_${HOST_ARCH}_${HOST_ENV}")
		dk_set(${HOST_TRIPLE}_host 1)	
		dk_set(${HOST_TRIPLE}_HOST 1)
		dk_printVar(${HOST_TRIPLE}_host)
		dk_printVar(${HOST_TRIPLE}_HOST)
	endif()
		
	dk_printVar(HOST_TRIPLE)
	dk_printVar(HOST_TRIPLE)
	dk_printVar(${HOST_TRIPLE})
	dk_printVar(${HOST_TRIPLE})	
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_host_triple()
endfunction()