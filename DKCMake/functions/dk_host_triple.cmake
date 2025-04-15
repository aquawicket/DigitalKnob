#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_host_triple()
#
#	set the cached host variables 
#
#	host_os 				= android, emscripten, ios, iossim, linux, mac, raspberry, windows
#	host_os 				= Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#	HOST_OS 				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	host_arch				= arm32, arm64, x86, x86_64
#	Host_Arch				= Arm32, Arm64, X86, X86_64
#	HOST_ARCH				= ARM32, ARM64, X86, X86_64
#	host_env				= clang, mingw, msvc, ucrt
#	Host_Env				= Clang, Mingw, Msvc, Ucrt
#	HOST_ENV				= CLANG, MINGW, MSVC, UCRT
#	<os>_host 				= android_host, emscripten_host, ios_host, iossim_host, linux_host, mac_host, raspberry_host, windows_host
#	<os>_host 				= Android_Host, Emscripten_Host, Ios_Host, Iossim_Host, Linux_Host, Mac_Host, Raspberry_Host, Windows_Host
#	<OS>_HOST 				= ANDROID_HOST, EMSCRIPTEN_HOST, IOS_HOST, IOSSIM_HOST, LINUX_HOST, MAC_HOST, RASPBERRY_HOST, WINDOWS_HOST 
#   <os>_<arch>_host		= android_arm64_host, emscripten_arm64_host, ios_arm64_host, iossim_arm64_host, linux_arm64_host, mac_arm64_host, raspberry_arm64_host, windows_arm64_host
#   <os>_<arch>_host		= Android_Arm64_Host, Emscripten_Arm64_Host, Ios_Arm64_Host, Iossim_Arm64_Host, Linux_Arm64_Host, Mac_Arm64_Host, Raspberry_Arm64_Host, Windows_Arm64_Host
#   <OS>_<ARCH>_HOST		= ANDROID_ARM64_HOST, EMSCRIPTEN_ARM64_HOST, IOS_ARM64_HOST, IOSSIM_ARM64_HOST, LINUX_ARM64_HOST, MAC_ARM64_HOST, RASPBERRY_ARM64_HOST, WINDOWS_ARM64_HOST 
#   <OS>_<ARCH>_<ENV>_HOST	= ANDROID_ARM64_CLANG_HOST, EMSCRIPTEN_ARM64_CLANG_HOST, IOS_ARM64_CLANG_HOST, IOSSIM_ARM64_CLANG_HOST, LINUX_ARM64_CLANG_HOST, MAC_ARM64_CLANG_HOST, RASPBERRY_ARM64_CLANG_HOST, WINDOWS_ARM64_CLANG_HOST 
#
function(dk_host_triple)
	dk_debugFunc()

#:: NOTICE: default environment moved to dk_target_triple()
#	#### DEFAULT HOST ENVIRONMENT ###
#	if(DEFINED ENV{Host_Env})
#		dk_set(Default_Host_Env $ENV{Host_Env})
#		dk_set(Host_Env $ENV{Host_Env})
#	endif()

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
		dk_set(unix_host 			1)
		dk_set(UNIX_HOST	    	1)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(Host_Os 			Android)
		elseif(CMAKE_HOST_APPLE)
			dk_set(Host_Os			Mac)
			dk_set(Apple_Host		1)
			dk_set(apple_host		1)
			dk_set(APPLE_HOST		1)
		else()
			dk_set(Host_Os 			Linux)
		endif()
	else()
		dk_fatal("CMAKE_HOST: Unknown host")
	endif()
	dk_assertVar(Host_Os)
	#d_k_toCamel(${Host_Os} Host_Os)    # Host_Os = Win
	dk_toLower(${Host_Os} host_os)      # host_os = win
	dk_toUpper(${Host_Os} HOST_OS)      # HOST_OS = WIN
	dk_set(Host_Os ${Host_Os})			# Globalize
	dk_set(host_os ${host_os})			# Globalize
	dk_set(HOST_OS ${HOST_OS})			# Globalize
	dk_set(${Host_Os}_Host 1)			# Win_Host = 1
	dk_set(${host_os}_host 1)			# win_host = 1
	dk_set(${HOST_OS}_HOST 1)			# WIN_HOST = 1
	dk_printVar(Host_Os)
	dk_printVar(host_os)
	dk_printVar(HOST_OS)
	dk_printVar(${Host_Os}_Host)
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
	#if(COSMOPOLITAN)
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
	dk_assertVar(Host_Arch)
	#d_k_toCamel(${Host_Arch} Host_Arch)     # Host_Arch = Arm64
	dk_toLower(${Host_Arch} host_arch)      # host_arch = arm64
	dk_toUpper(${Host_Arch} HOST_ARCH)      # HOST_ARCH = ARM64
	dk_set(Host_Arch ${Host_Arch})			# Globalize
	dk_set(host_arch ${host_arch})			# Globalize
	dk_set(HOST_ARCH ${HOST_ARCH})			# Globalize
	dk_set(${Host_Arch}_Host 1)				# Arm64_Host = 1
	dk_set(${host_arch}_host 1)				# arm64_host = 1
	dk_set(${HOST_ARCH}_HOST 1)				# ARM64_HOST = 1
	dk_printVar(Host_Arch)
	dk_printVar(host_arch)
	dk_printVar(HOST_ARCH)
	dk_printVar(${Host_Arch}_Host)
	dk_printVar(${host_arch}_host)
	dk_printVar(${HOST_ARCH}_HOST)
	
	#### Set Default host_env, HOST_ENV ###
#	dk_printVar(CMAKE_HOST_SYSTEM_NAME)
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
		dk_set(Host_Env 	"${Default_Host_Env}")
	elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
		dk_set(Host_Env 	"${Default_Host_Env}")
	elseif(MSVC)
		dk_set(Host_Env 	"Msvc")
	else()
		dk_set(Host_Env 	"${Default_Host_Env}")
	endif()
	#dk_assertVar(Host_Env)
	if(Host_Env)
		#d_k_toCamel(${Host_Env} Host_Env)		# Host_Env = Msvc
		dk_toLower(${Host_Env} host_env)		# host_env = msvc
		dk_toUpper(${Host_Env} HOST_ENV)		# HOST_ENV = MSVC
		dk_set(Host_Env ${Host_Env})			# Globalize
		dk_set(host_env ${host_env})			# Globalize
		dk_set(HOST_ENV ${HOST_ENV})			# Globalize
		dk_set(${Host_Env}_Host 1)				# Msvc_Host = 1
		dk_set(${host_env}_host 1)				# msvc_host = 1
		dk_set(${HOST_ENV}_HOST 1)				# MSVC_HOST = 1
		dk_printVar(Host_Env)
		dk_printVar(host_env)
		dk_printVar(HOST_ENV)
		dk_printVar(${Host_Env}_Host)
		dk_printVar(${host_env}_host)
		dk_printVar(${HOST_ENV}_HOST)
	endif()
	
	### set host_triple ###
	if(Host_Arch)
		dk_set(Host_Triple "${Host_Os}_${Host_Arch}")
		dk_set(host_triple "${host_os}_${host_arch}")
		dk_set(HOST_TRIPLE "${HOST_OS}_${HOST_ARCH}")
		dk_set(${Host_Triple}_Host 1)
		dk_set(${host_triple}_host 1)
		dk_set(${HOST_TRIPLE}_HOST 1)
		dk_printVar(${Host_Triple}_Host)
		dk_printVar(${host_triple}_host)
		dk_printVar(${HOST_TRIPLE}_HOST)
	endif()
	if(Host_Env)
		dk_set(Host_Triple "${Host_Os}_${Host_Arch}_${Host_Env}")
		dk_set(host_triple "${host_os}_${host_arch}_${host_env}")
		dk_set(HOST_TRIPLE "${HOST_OS}_${HOST_ARCH}_${HOST_ENV}")
		dk_set(${Host_Triple}_Host 1)
		dk_set(${host_triple}_host 1)		
		dk_set(${HOST_TRIPLE}_HOST 1)
		dk_printVar(${Host_Triple}_Host)
		dk_printVar(${host_triple}_host)
		dk_printVar(${HOST_TRIPLE}_HOST)
	endif()
		
	if((NOT Host_Triple) AND (cosmopolitan OR cosmopolitan OR COSMOPOLITAN))
		dk_set(Host_Triple "Cosmopolitan")
		dk_set(host_triple "cosmopolitan")
		dk_set(HOST_TRIPLE "COSMOPOLITAN")
		dk_set(${Host_Triple}_Host 1)
		dk_set(${host_triple}_host 1)
		dk_set(${HOST_TRIPLE}_HOST 1)
		dk_printVar(${Host_Triple}_Host)
		dk_printVar(${host_triple}_host)
		dk_printVar(${HOST_TRIPLE}_HOST)
	endif()

	dk_printVar(Host_Triple)
	dk_printVar(host_triple)
	dk_printVar(HOST_TRIPLE)
	dk_printVar(${Host_Triple}_Host)
	dk_printVar(${host_triple}_host)
	dk_printVar(${HOST_TRIPLE}_HOST)	
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_host_triple()
endfunction()
