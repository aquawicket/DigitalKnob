include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getTargetTriple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	TARGET_OS 					= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	TARGET_ARCH					= arm32, arm64, x86, x86_64
#	TARGET_ENV					= clang, mingw, msvc, ucrt
#	<os>_target					= android_host, emscripten_host, ios_host, iossim_host, linux_host, mac_host, raspberry_host, windows_host 
#   <os>_<arch>_target			= android_arm64_host, emscripten_arm64_host, ios_arm64_host, iossim_arm64_host, linux_arm64_host, mac_arm64_host, raspberry_arm64_host, windows_arm64_host 
#   <os>_<arch>_<env>_target	= android_arm64_clang_host, emscripten_arm64_clang_host, ios_arm64_clang_host, iossim_arm64_clang_host, linux_arm64_clang_host, 								
#								  mac_arm64_clang_host, raspberry_arm64_clang_host, windows_arm64_clang_host 
function(dk_getTargetTriple)
	dk_debugFunc(${ARGV})
	
	### Get TARGET_DIR ###
#	if(ARGV0)
#		dk_getFullPath("${ARGV0}" TARGET_DIR)  			
#	else()
		dk_getFullPath("${CMAKE_BINARY_DIR}" TARGET_DIR) 			
#	endif()
	dk_printVar(TARGET_DIR)								# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang/Debug
		
	### Get TARGET_TYPE ###
	if(${TARGET_DIR} MATCHES "Debug")	
		### Get DEBUG ###
		dk_set(DEBUG 1)									# DEBUG = 1							
			
		dk_set(TARGET_TYPE Debug)						# TARGET_TYPE = Debug					
		
		dk_dirname(${TARGET_DIR} TARGET_TRIPLE_DIR)	
		dk_printVar(TARGET_TRIPLE_DIR)					# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	elseif(${TARGET_DIR} MATCHES "Release")	
		### Get RELEASE ###
		dk_set(RELEASE 1)								# RELEASE = 1						
		
		dk_set(TARGET_TYPE Release)						
		dk_printVar(TARGET_TYPE)						# TARGET_TYPE = Release
		
		dk_dirname(${TARGET_DIR} TARGET_TRIPLE_DIR)		
		dk_printVar(TARGET_TRIPLE_DIR)					# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	else()
		dk_set(TARGET_TRIPLE_DIR ${TARGET_DIR})
		dk_printVar(TARGET_TRIPLE_DIR)					# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	endif()

	### Get TARGET_TRIPLE_FOLDER ###
	dk_basename(${TARGET_TRIPLE_DIR} TARGET_TRIPLE)
	dk_printVar(TARGET_TRIPLE)							# TARGET_TRIPLE = win_x86_64_clang

	### Set TARGET_TRIPLE ###
	dk_set(${TARGET_TRIPLE} 1)							# win_x86_64_clang = 1
			
	### Get TARGET_OS
	if(TARGET_TRIPLE MATCHES "android")
		dk_set(TARGET_OS android)
	elseif(TARGET_TRIPLE MATCHES "emscripten")
		dk_set(TARGET_OS emscripten)
	elseif(TARGET_TRIPLE MATCHES "iossim")
		dk_set(TARGET_OS iossim)
	elseif(TARGET_TRIPLE MATCHES "ios")
		dk_set(TARGET_OS ios)
	elseif(TARGET_TRIPLE MATCHES "linux")
		dk_set(TARGET_OS linux)
	elseif(TARGET_TRIPLE MATCHES "mac")
		dk_set(TARGET_OS mac)
	elseif(TARGET_TRIPLE MATCHES "rasp")
		dk_set(TARGET_OS raspberry)
	elseif(TARGET_TRIPLE MATCHES "win")
		dk_set(TARGET_OS win)
	else()
		dk_warning("The TARGET_TRIPLE:${TARGET_TRIPLE} does not contain a valid TARGET_OS")
		dk_setTargetTriple()
		return()
	endif()
	dk_set(${TARGET_OS}_target 1)
	dk_toUpper(${TARGET_OS}_target TARGET_OS_UPPER)
	dk_set(${TARGET_OS_UPPER} 1)
	
	
	### Get TARGET_ARCH
	if(TARGET_TRIPLE MATCHES "arm64")
		dk_set(TARGET_ARCH arm64)
	elseif(TARGET_TRIPLE MATCHES "arm32")
		dk_set(TARGET_ARCH arm32)
	elseif(TARGET_TRIPLE MATCHES "x86_64")
		dk_set(TARGET_ARCH x86_64)
	elseif(TARGET_TRIPLE MATCHES "x86")
		dk_set(TARGET_ARCH x86)
	else()
		dk_warning("The TARGET_TRIPLE:${TARGET_TRIPLE} does not contain a valid TARGET_ARCH")
		dk_setTargetTriple()
		return()
	endif()
	dk_set(${TARGET_ARCH}_target 1)
	dk_toUpper(${TARGET_ARCH}_target TARGET_ARCH_UPPER)
	dk_set(${TARGET_ARCH_UPPER} 1)
	
	### Get TARGET_ENV
	if(TARGET_TRIPLE MATCHES "clang")
		dk_set(TARGET_ENV clang)
	elseif(TARGET_TRIPLE MATCHES "mingw")
		dk_set(TARGET_ENV mingw)
	elseif(TARGET_TRIPLE MATCHES "ucrt")
		dk_set(TARGET_ENV ucrt)
	elseif(TARGET_TRIPLE MATCHES "msvc")
		dk_set(TARGET_ENV msvc)
	else()
		dk_warning("The TARGET_TRIPLE:${TARGET_TRIPLE} does not contain a valid TARGET_ENV")
	endif()
	dk_set(${TARGET_ENV}_target 1)
	dk_toUpper(${TARGET_ENV}_target TARGET_ENV_UPPER)
	dk_set(${TARGET_ENV_UPPER} 1)
	
	### Set MSYSTEM
	if(TARGET_ENV)
		dk_toUpper(${TARGET_ENV} TARGET_ENV_UPPER)
		if(ARM64_TARGET)
			dk_set(MSYSTEM "${TARGET_ENV_UPPER}ARM64")	# CLANGARM64
		#elseif(ARM32_TARGET)
		#	dk_set(MSYSTEM "${TARGET_ENV_UPPER}ARM32")
		elseif(X86_64_TARGET)
			dk_set(MSYSTEM "${TARGET_ENV_UPPER}64")		# CLANG64, MINGW64, UCRT64
		elseif(X86_TARGET)
			dk_set(MSYSTEM "${TARGET_ENV_UPPER}32")		# CLANG32, MINGW32
		else()
			dk_error("The TARGET_TRIPLE:${TARGET_TRIPLE} does not contain a valid MSYSTEM")
		endif()
		dk_set(${MSYSTEM} 1)
	endif()
		
	### Set TARGET_OS_ARCH ###
	dk_set(TARGET_OS_ARCH "${TARGET_OS}_${TARGET_ARCH}")  

	### Set DK_PROJECT_DIR ###
	dk_dirname(${TARGET_TRIPLE_DIR} DK_PROJECT_DIR)
	dk_set(DK_PROJECT_DIR ${DK_PROJECT_DIR})

	### Set OS ###
	dk_set(OS "${TARGET_TRIPLE}")

	### Set ${OS} variable ##
	dk_toUpper(${TARGET_OS} TARGET_OS_UPPER)
	dk_set(${TARGET_OS_UPPER} 1)

	### Set ARCH variable ##
	if(TARGET_ARCH)
		dk_toUpper(${TARGET_ARCH} TARGET_ARCH_UPPER)
	endif()

	if(TARGET_ARCH_UPPER)
		dk_set(${TARGET_ARCH_UPPER} 1)
	endif()

	### Set ${OS_ARCH} ###
	dk_set(${TARGET_OS_UPPER}_${TARGET_ARCH_UPPER} 1)

	### Set DEBUG_DIR and RELEASE_DIR variables
	if(${IOS_TARGET})
		dk_set(DEBUG_DIR Debug-iphoneos)
		dk_set(RELEASE_DIR Release-iphoneos)
	elseif(${IOSSIM_TARGET})
		dk_set(DEBUG_DIR Debug-iphonesimulator)
		dk_set(RELEASE_DIR Release-iphonesimulator)
	else()
		dk_set(DEBUG_DIR Debug)
		dk_set(RELEASE_DIR Release)
	endif()
			
	###### CHECK VARIABLES ######
	dk_assert(TARGET_DIR)
	dk_assert(TARGET_OS)
	dk_assert(TARGET_ARCH)
	#dk_assert(TARGET_ENV)
	dk_assert(TARGET_TRIPLE)
	dk_assert(DK_PROJECT_DIR)
	dk_assert(OS)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	#dk_getTargetTriple("C:/Users/Administrator/digitalknob/Development/DKApps/DKSDLRml/win_x86_64_clang/Debug")
	dk_getTargetTriple()
endfunction()