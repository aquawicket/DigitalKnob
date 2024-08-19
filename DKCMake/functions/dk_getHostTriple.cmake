include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getHostTriple()
#
#	set the cached host variables 
#
#	DK_HOST_OS 		= WIN, APPLE, LINUX, ANDROID
#	DK_HOST_ARCH	= arm32, arm64, x86, x86_64
#	DK_HOST_ENV		= clang, mingw, ucrt
#	<OS>_HOST 		= ANDROID_HOST, MAC_HOST, UNIX_HOST, WIN_HOST, ect..


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
	
	###### Set OS_HOST variables ######
	if(CMAKE_HOST_WIN32)
		dk_set(WIN_HOST 		TRUE)
	endif()
	if(CMAKE_HOST_APPLE)
		dk_set(UNIX_HOST 		TRUE)
		dk_set(MAC_HOST 		TRUE)
	endif()
	if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
		dk_set(DK_HOST_OS      linux)
		dk_set(UNIX_HOST 		TRUE)
		dk_set(LINUX_HOST 		TRUE)	
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(ANDROID_HOST TRUE)
		endif()
	endif()
	
	###### Set DK_HOST_OS variable ######
	if(CMAKE_HOST_WIN32)
		dk_set(DK_HOST_OS		win)
		dk_set(HOST		    	WIN)
	elseif(CMAKE_HOST_APPLE)
		dk_set(DK_HOST_OS		mac)
		dk_set(HOST				APPLE)
	elseif(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(DK_HOST_OS	android)
			dk_set(HOST	ANDROID)
		else()
			dk_set(DK_HOST_OS	linux)
			dk_set(HOST	LINUX)
		endif()
	else()
		dk_error("CMAKE_HOST: Unknown host")
	endif()
	
	### Set DK_HOST_ARCH
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
		dk_set(DK_HOST_ARCH arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
		dk_set(DK_HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
		dk_set(DK_HOST_ARCH arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
		dk_set(DK_HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
		dk_set(DK_HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
		dk_set(DK_HOST_ARCH x86)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		dk_set(DK_HOST_ARCH x86_64)
	else()
		dk_error("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
	endif()
	
	dk_toUpper(${DK_HOST_OS}   DK_HOST_OS_UPPER)
	dk_toUpper(${DK_HOST_ARCH} DK_HOST_ARCH_UPPER)
	
	dk_set(${DK_HOST_ARCH_UPPER} TRUE) # set ARCH to TRUE
	
	### set [HOST]_[DK_HOST_ARCH] variable
	dk_set(${DK_HOST_OS_UPPER}_${DK_HOST_ARCH_UPPER}_HOST TRUE)
	
	#### Set Default DK_HOST_ENV ###
	if("${DK_HOST_OS}" STREQUAL "win")
		dk_set(DK_HOST_ENV "clang")
	endif()
	
	### set DK_HOST_TRIPLE ###
	if(DK_HOST_ENV)
		dk_set(DK_HOST_TRIPLE ${DK_HOST_OS}_${DK_HOST_ARCH}_${DK_HOST_ENV})
	else()
		dk_set(DK_HOST_TRIPLE ${DK_HOST_OS}_${DK_HOST_ARCH})
	endif()
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()