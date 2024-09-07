include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getHostTriple()
#
#	set the cached host variables 
#
#	HOST_OS 				= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	HOST_ARCH				= arm32, arm64, x86, x86_64
#	HOST_ENV				= clang, mingw, msvc, ucrt
#	<os>_host 				= android_host, emscripten_host, ios_host, iossim_host, linux_host, mac_host, raspberry_host, windows_host 
#   <os>_<arch>_host		= android_arm64_host, emscripten_arm64_host, ios_arm64_host, iossim_arm64_host, linux_arm64_host, mac_arm64_host, raspberry_arm64_host, windows_arm64_host 
#   <os>_<arch>_<env>_host	= android_arm64_clang_host, emscripten_arm64_clang_host, ios_arm64_clang_host, iossim_arm64_clang_host, linux_arm64_clang_host, 								
#							  mac_arm64_clang_host, raspberry_arm64_clang_host, windows_arm64_clang_host 
function(dk_getHostTriple)
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
	
	###### Set HOST_OS and {OS}_HOST ######
	if(CMAKE_HOST_WIN32)
		dk_set(HOST_OS				win)
	elseif(CMAKE_HOST_UNIX)
		dk_set(unix_host 			1)
		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
			dk_set(HOST_OS 			android)
		elseif(CMAKE_HOST_APPLE)
			dk_set(HOST_OS			mac)
			dk_set(apple_host		1)
		else()
			dk_set(HOST_OS 			linux)
		endif()
	else()
		dk_fatal("CMAKE_HOST: Unknown host")
	endif()
	dk_set(${HOST_OS}_host 1)
	dk_toUpper(${HOST_OS}_host HOST_OS_UPPER)
	dk_set(${HOST_OS_UPPER} 1)
	
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
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "AMD64")
		dk_set(HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "ARM64")
		dk_set(HOST_ARCH arm64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "EM64T")
		dk_set(HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "IA64")
		dk_set(HOST_ARCH x86_64)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86")
		dk_set(HOST_ARCH x86)
	elseif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		dk_set(HOST_ARCH x86_64)
	else()
		dk_fatal("CMAKE_HOST_SYSTEM_PROCESSOR: Unknown arch: \"${CMAKE_HOST_SYSTEM_PROCESSOR}\"")
	endif()
	if(HOST_ARCH)
		dk_set(${HOST_ARCH}_host 1)
		dk_toUpper(${HOST_ARCH}_host HOST_ARCH_UPPER)
		dk_set(${HOST_ARCH_UPPER} 1)
	endif()

	#### Set Default HOST_ENV ###
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MSYS")
		dk_set(HOST_ENV 	"clang")
	elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "MINGW")
		dk_set(HOST_ENV 	"clang")
	elseif(MSVC)
		dk_set(HOST_ENV 	"msvc")
	endif()
	if(HOST_ENV)
		dk_set(${HOST_ENV}_host 1)
		dk_toUpper(${HOST_ARCH}_host HOST_ARCH_UPPER)
		dk_set(${HOST_ARCH_UPPER} 1)
	endif()
	
	
	### set HOST_TRIPLE ###
	if(HOST_OS)
		dk_set(HOST_TRIPLE ${HOST_OS})
		dk_set(${HOST_TRIPLE}_host 1)
		dk_toUpper(${HOST_TRIPLE}_host HOST_TRIPLE_UPPER)					# win
		dk_set(${HOST_TRIPLE_UPPER} 1)
		if(HOST_ARCH)
			dk_set(HOST_TRIPLE ${HOST_TRIPLE}_${HOST_ARCH})
			dk_set(${HOST_TRIPLE}_host 1)									# win_x86_64
			dk_toUpper(${HOST_TRIPLE}_host HOST_TRIPLE_UPPER)
			dk_set(${HOST_TRIPLE_UPPER} 1)
			if(HOST_ENV)
				dk_set(HOST_TRIPLE ${HOST_TRIPLE}_${HOST_ENV})     
				dk_set(${HOST_TRIPLE}_host 1)								# win_x86_64_msvc
				dk_toUpper(${HOST_TRIPLE}_host HOST_TRIPLE_UPPER)
				dk_set(${HOST_TRIPLE_UPPER} 1)
			endif()
		endif()
	endif()

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_getHostTriple()
endfunction()