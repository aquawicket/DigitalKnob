#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_target_triple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	If the CMAKE_BINARY_DIR is missing the <OS> or the <ARCH>, dk_target_triple2 will be called to get those variables
#
#	os   				= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	OS   				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	arch				= arm32, arm64, x86, x86_64
#	ARCH				= ARM32, ARM64, X86, X86_64
#	env					= clang, cosmo, mingw, msvc, ucrt
#	ENV					= CLANG, COSMO, MINGW, MSVC, UCRT
#   <os>_<arch>			= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
#   <os>_<arch>_<env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
#
function(dk_target_triple)
	dk_debugFunc(0 1)

	set(default_target_env "clang")
	
	### Get TARGET_DIR ###
	dk_getFullPath("${CMAKE_BINARY_DIR}" TARGET_DIR)
	dk_printVar(TARGET_DIR)								# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang/Debug

	### Set target_type / TARGET_TYPE ###
	if(TARGET_DIR MATCHES "Debug")	
		### Get DEBUG ###
		dk_set(DKBUILD_TYPE DEBUG)						# 			   DKBUILD_TYPE	= DEBUG
		dk_set(${DKBUILD_TYPE} 1)						# 			  DEBUG = 1	
		#dk_set(TARGET_TYPE Debug)						# 		TARGET_TYPE	= Debug
		dk_dirname(${TARGET_DIR} TARGET_TRIPLE_DIR)		# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang

	elseif(TARGET_DIR MATCHES "Release")
		### Get RELEASE ###
		dk_set(DKBUILD_TYPE RELEASE)					# 			   DKBUILD_TYPE = RELEASE
		dk_set(${DKBUILD_TYPE} 1)						#			RELEASE = 1	
		#dk_set(TARGET_TYPE Release)					# 		TARGET_TYPE = Release
		dk_dirname(${TARGET_DIR} TARGET_TRIPLE_DIR)		# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	endif()
		if( (TARGET_DIR MATCHES "android") 		OR
			(TARGET_DIR MATCHES "emscripten") 	OR
			(TARGET_DIR MATCHES "ios") 			OR
			(TARGET_DIR MATCHES "iossim")		OR		 
			(TARGET_DIR MATCHES "linux") 		OR
			(TARGET_DIR MATCHES "mac") 			OR
			(TARGET_DIR MATCHES "raspberry") 	OR
			(TARGET_DIR MATCHES "windows")		OR
			(TARGET_DIR MATCHES "cosmo"))
			dk_set(TARGET_TRIPLE_DIR ${TARGET_DIR})			# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
		else()
			dk_target_triple2()
			dk_set(TARGET_TRIPLE_DIR ${TARGET_DIR}/${triple})
		endif()

	if(NOT EXISTS ${TARGET_TRIPLE_DIR})
		dk_warning("TARGET_TRIPLE_DIR:${TARGET_TRIPLE_DIR} does not exits.")
		dk_debug("Creating directory . . .${TARGET_TRIPLE_DIR} ")
		dk_makeDirectory(${TARGET_TRIPLE_DIR})
	endif()
	dk_assertPath(TARGET_TRIPLE_DIR)
		
	### Set DK_PROJECT_DIR ###
	dk_dirname(${TARGET_TRIPLE_DIR} DK_PROJECT_DIR)
	dk_set(DK_PROJECT_DIR ${DK_PROJECT_DIR})
	dk_assertPath(DK_PROJECT_DIR)

	### Set triple/TRIPLE, <os>_<arch>_<env>/<OS>_<ARCH>_<ENV> ###
	message("TARGET_TRIPLE_DIR = ${TARGET_TRIPLE_DIR}")
	dk_basename(${TARGET_TRIPLE_DIR} triple)	# 			triple 	= win_x86_64_clang
	message("triple = ${triple}")
	dk_set(triple ${triple})					# 					  Globalize the variable
	dk_set(target_triple ${triple})				# 	  target_triple	= win_x86_64_clang
	dk_toUpper(${triple} TRIPLE)				# 			 TRIPLE	= WIN_X86_64_CLANG
	dk_set(TRIPLE ${TRIPLE})					# 					  Globalize the variable
	dk_set(TARGET_TRIPLE ${TRIPLE})				# 	  TARGET_TRIPLE = WIN_X86_64_CLANG
	dk_set(${triple} 1)					        #  win_x86_64_clang = 1
	dk_set(${TRIPLE} 1)					        #  WIN_X86_64_CLANG = 1
	dk_printVar(triple)
	dk_printVar(TRIPLE)


	### Set os / OS / <os>_target / <OS>_TARGET
	if(triple MATCHES "android")
		dk_set(os android)
	elseif(triple MATCHES "emscripten")
		dk_set(os emscripten)
	elseif(triple MATCHES "iossim")
		dk_set(os iossim)
	elseif(triple MATCHES "ios")
		dk_set(os ios)
	elseif(triple MATCHES "linux")
		dk_set(os linux)
	elseif(triple MATCHES "mac")
		dk_set(os mac)
	elseif(triple MATCHES "raspberry")
		dk_set(os raspberry)
	elseif(triple MATCHES "windows")
		dk_set(os windows)
	elseif(triple MATCHES "win")
		dk_set(os win)
	elseif(triple MATCHES "cosmo")
		dk_set(os cosmo)	
	else()
		dk_warning("The target triple:${triple} does not contain a valid os")
		dk_unset(triple)
		dk_unset(TRIPLE)
		dk_target_triple2()
	endif()
	if(os)
		dk_toUpper(${os} OS)
		dk_set(OS ${OS})
		#dk_set(target_os ${os})
		#dk_set(TARGET_OS ${OS})
		dk_set(${os} 1)
		dk_set(${OS} 1)
		#dk_set(${os}_target 1)
		#dk_set(${OS}_TARGET 1)
	endif()


	### Get arch / ARCH
	if(triple MATCHES "arm64")
		dk_set(arch arm64)
	elseif(triple MATCHES "arm32")
		dk_set(arch arm32)
	elseif(triple MATCHES "x86_64")
		dk_set(arch x86_64)
	elseif(triple MATCHES "x86")
		dk_set(arch x86)
	elseif(triple MATCHES "cosmo")
		dk_set(arch cosmo)	
	else()
		dk_warning("The target triple:${triple} does not contain a valid arch")
		dk_target_triple2()
	endif()
	if(arch)
		dk_toUpper(${arch} ARCH)
		dk_set(ARCH ${ARCH})
		#dk_set(target_arch ${arch})
		#dk_set(TARGET_ARCH ${ARCH})
		dk_set(${arch} 1)
		dk_set(${ARCH} 1)
		#dk_set(${arch}_target 1)
		#dk_set(${ARCH}_TARGET 1)
	endif()


	### Set evn / ENV 
	if(triple MATCHES "clang")
		dk_set(env clang)
	elseif(triple MATCHES "mingw")
		dk_set(env mingw)
	elseif(triple MATCHES "ucrt")
		dk_set(env ucrt)
	elseif(triple MATCHES "msvc")
		dk_set(env msvc)
	elseif(triple MATCHES "cosmo")
		dk_set(env cosmo)
	else()
		dk_warning("The target triple:${triple} does not contain a valid env")
		dk_set(env ${default_target_env})
	endif()
	if(env)
		dk_toUpper(${env} ENV)
		dk_set(ENV ${ENV})
		#dk_set(target_env ${env})
		#dk_set(TARGET_ENV ${ENV})
		dk_set(${env} 1)
		dk_set(${ENV} 1)
		#dk_set(${env}_target 1)
		#dk_set(${ENV}_TARGET 1)
	endif()

	### Set MSYSTEM
	if(${ENV})
		dk_MSYSTEM()
	endif()
		
	### Set os_arch / OS_ARCH ###
	dk_set(os_arch "${os}_${arch}")
	dk_set(OS_ARCH "${OS}_${ARCH}")
	#dk_set(target_os_arch "${os_arch}")
	#dk_set(TARGET_OS_ARCH "${OS_ARCH}")
	dk_set(${os_arch} 1)
	dk_set(${OS_ARCH} 1)
	#dk_set(${os_arch}_target 1)
	#dk_set(${OS_ARCH}_TARGET 1)

	### Set DEBUG_DIR and RELEASE_DIR variables
	if(IOS)
		dk_set(DEBUG_DIR Debug-iphoneos)
		dk_set(RELEASE_DIR Release-iphoneos)
	elseif(IOSSIM)
		dk_set(DEBUG_DIR Debug-iphonesimulator)
		dk_set(RELEASE_DIR Release-iphonesimulator)
	else()
		dk_set(DEBUG_DIR Debug)
		dk_set(RELEASE_DIR Release)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_target_triple()
endfunction()
