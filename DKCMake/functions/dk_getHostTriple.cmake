include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getHostTriple()
#
#	set the cached host variables 
#
#	HOST_OS 	= WIN, APPLE, LINUX, ANDROID
#	HOST_ARCH	= arm32, arm64, x86, x86_64
#	HOST_ENV	= clang, mingw, ucrt
#	<OS>_HOST 	= ANDROID_HOST, MAC_HOST, UNIX_HOST, WIN_HOST, ect..


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
	
	###### Set HOST_OS and {OS}_HOST ######
	if(CMAKE_HOST_WIN32)
		dk_set(HOST_OS				win)
		dk_set(WIN_HOST 			1)
	elseif(CMAKE_HOST_UNIX)
		dk_set(UNIX_HOST 			1)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(HOST_OS 			android)
			dk_set(ANDROID_HOST 	1)
		elseif(CMAKE_HOST_APPLE)
			dk_set(HOST_OS			mac)
			dk_set(APPLE_HOST		1)
			dk_set(MAC_HOST 		1)
		else()
			dk_set(HOST_OS 			linux)
			dk_set(LINUX_HOST 		1)
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

	
	if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
		dk_set(HOST_ARCH arm64)
		dk_set(ARM64_HOST)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
		dk_set(HOST_ARCH x86_64)
		dk_set(X86_64_HOST)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
		dk_set(HOST_ARCH arm64)
		dk_set(ARM64_HOST)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
		dk_set(HOST_ARCH x86_64)
		dk_set(X86_64_HOST)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
		dk_set(HOST_ARCH x86_64)
		dk_set(X86_64_HOST)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
		dk_set(HOST_ARCH x86)
		dk_set(X86_HOST)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		dk_set(HOST_ARCH x86_64)
		dk_set(X86_64_HOST)
	else()
		dk_error("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
	endif()
	

	#### Set Default HOST_ENV ###
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
		dk_set(HOST_ENV 	"clang")
		dk_set(CLANG_HOST	1)
	elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
		dk_set(HOST_ENV 	"clang")
		dk_set(CLANG_HOST	1)
	elseif(MSVC)
		dk_set(HOST_ENV 	"msvc")
		dk_set(MSVC_HOST	1)
	endif()
	
	
	### set HOST_TRIPLE ###
	if(HOST_ENV)
		dk_set(HOST_TRIPLE ${HOST_OS}_${HOST_ARCH}_${HOST_ENV})
	else()
		dk_set(HOST_TRIPLE ${HOST_OS}_${HOST_ARCH})
	endif()
	dk_toUpper(${HOST_TRIPLE} HOST_TRIPLE)

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_getHostTriple()
endfunction()