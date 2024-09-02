include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getTargetTriple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	target_os, os   			= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	TARGET_OS, OS   			= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	target_arch, arch			= arm32, arm64, x86, x86_64
#	TARGET_ARCH, ARCH			= ARM32, ARM64, X86, X86_64
#	target_env, env				= clang, mingw, msvc, ucrt
#	TARGET_ENV, ENV				= CLANG, MINGW, MSVC, UCRT
#	<os>_target					= android_target, emscripten_target, ios_target, iossim_target, linux_target, mac_target, raspberry_target, windows_target 
#   <os>_<arch>_target			= android_arm64_target, emscripten_arm64_target, ios_arm64_target, iossim_arm64_target, linux_arm64_target, mac_arm64_target, 
#                                 raspberry_arm64_target, windows_arm64_target 
#   <os>_<arch>_<env>_target	= android_arm64_clang_target, emscripten_arm64_clang_target, ios_arm64_clang_target, iossim_arm64_clang_target, 
#                                 linux_arm64_clang_target, mac_arm64_clang_target, raspberry_arm64_clang_target, windows_arm64_clang_target 
function(dk_getTargetTriple)
	dk_debugFunc(${ARGV})
	
	### Get TARGET_DIR ###
#	if(ARGV0)
#		dk_getFullPath("${ARGV0}" TARGET_DIR)  			
#	else()
	dk_getFullPath("${CMAKE_BINARY_DIR}" TARGET_DIR)
#	endif()
	dk_printVar(TARGET_DIR)								# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang/Debug
		
	### Set target_type / TARGET_TYPE ###
	if(${TARGET_DIR} MATCHES "Debug")	
		### Get DEBUG ###
		dk_set(TYPE DEBUG)						        # TYPE = DEBUG
		dk_set(${TYPE} 1)								# DEBUG = 1	
		dk_set(TARGET_TYPE Debug)						# TARGET_TYPE = Debug
		dk_dirname(${TARGET_DIR} TARGET_TRIPLE_DIR)		# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	
	elseif(${TARGET_DIR} MATCHES "Release")	
		### Get RELEASE ###
		dk_set(TYPE RELEASE)						    # TYPE = RELEASE
		dk_set(${TYPE} 1)								# RELEASE = 1	
		dk_set(TARGET_TYPE Release)						# TARGET_TYPE = Release
		dk_dirname(${TARGET_DIR} TARGET_TRIPLE_DIR)		# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	else()
		dk_set(TARGET_TRIPLE_DIR ${TARGET_DIR})			# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	endif()
	dk_printVar(TARGET_TRIPLE_DIR)
	
	
	### Set target_triple / TARGET_TRIPLE / <OS>_<ARCH>_<ENV> ###
	dk_basename(${TARGET_TRIPLE_DIR} triple)	# triple        = win_x86_64_clang	
	dk_set(target_triple ${triple})				# target_triple = win_x86_64_clang							
	dk_toUpper(${triple} TRIPLE)				# TRIPLE        = WIN_X86_64_CLANG
	dk_set(TARGET_TRIPLE ${TRIPLE})				# TARGET_TRIPLE = WIN_X86_64_CLANG	
	dk_set(${triple} 1)					        # win_x86_64_clang = 1
	dk_set(${TRIPLE} 1)					        # WIN_X86_64_CLANG = 1
	dk_printVar(triple)
	dk_printVar(TRIPLE)
	
	
	### Set os / OS / <os>_target / <OS>_TARGET
	if(target_triple MATCHES "android")
		dk_set(os android)
	elseif(target_triple MATCHES "emscripten")
		dk_set(os emscripten)
	elseif(target_triple MATCHES "iossim")
		dk_set(os iossim)
	elseif(target_triple MATCHES "ios")
		dk_set(os ios)
	elseif(target_triple MATCHES "linux")
		dk_set(os linux)
	elseif(target_triple MATCHES "mac")
		dk_set(os mac)
	elseif(target_triple MATCHES "rasp")
		dk_set(os raspberry)
	elseif(target_triple MATCHES "windows")
		dk_set(os windows)
	elseif(target_triple MATCHES "win")
		dk_set(os win)
	else()
		dk_warning("The target_triple:${target_triple} does not contain a valid target_os")
		dk_setTargetTriple()
		return()
	endif()
	dk_toUpper(${os} OS)
	dk_set(target_os ${os})
	dk_set(TARGET_OS ${OS})
	dk_set(${os} 1)
	dk_set(${OS} 1)
	dk_set(${os}_target 1)
	dk_set(${OS}_TARGET 1)
	
	##### TEMPORARY FIX #####
	dk_set(OS ${target_triple})
	
	
	### Get arch / ARCH / <arch>_target / <ARCH>_TARGET
	if(target_triple MATCHES "arm64")
		dk_set(arch arm64)
	elseif(target_triple MATCHES "arm32")
		dk_set(arch arm32)
	elseif(target_triple MATCHES "x86_64")
		dk_set(arch x86_64)
	elseif(target_triple MATCHES "x86")
		dk_set(arch x86)
	else()
		dk_warning("The target_triple:${target_triple} does not contain a valid TARGET_ARCH")
		dk_setTargetTriple()
		return()
	endif()
	dk_toUpper(${arch} ARCH)
	dk_set(target_arch ${arch})
	dk_set(TARGET_ARCH ${ARCH})
	dk_set(${arch} 1)
	dk_set(${ARCH} 1)
	dk_set(${arch}_target 1)
	dk_set(${ARCH}_TARGET 1)
	
	
	### Set evn / ENV / <env>_target / <ENV>_TARGET
	if(target_triple MATCHES "clang")
		dk_set(env clang)
	elseif(target_triple MATCHES "mingw")
		dk_set(env mingw)
	elseif(target_triple MATCHES "ucrt")
		dk_set(env ucrt)
	elseif(target_triple MATCHES "msvc")
		dk_set(env msvc)
	else()
		dk_warning("The target_triple:${target_triple} does not contain a valid TARGET_ENV")
	endif()
	dk_toUpper(${env} ENV)
	dk_set(target_env ${env})
	dk_set(TARGET_ENV ${ENV})
	dk_set(${env} 1)
	dk_set(${ENV} 1)
	dk_set(${env}_target 1)
	dk_set(${ENV}_TARGET 1)
	
	### Set MSYSTEM
	if(${ENV})
		if(CLANG AND ARM64)
			dk_set(MSYSTEM "${ENV}${ARCH}")	# MSYSTEM = CLANGARM64
		elseif(X86_64)
			dk_set(MSYSTEM "${ENV}64")		# MSYSTEM = CLANG64, MINGW64, UCRT64
		elseif(X86)
			dk_set(MSYSTEM "${ENV}32")		# MSYSTEM = CLANG32, MINGW32
		else()
			dk_error("The target_triple:${target_triple} does not contain a valid ENV or MSYSTEM")
		endif()
		dk_set(${MSYSTEM} 1)				# CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	endif()
		
	### Set os_arch / OS_ARCH / target_os_arch / TARGET_OS_ARCH ###
	dk_set(os_arch "${os}_${arch}")
	dk_set(OS_ARCH "${OS}_${ARCH}")
	dk_set(target_os_arch "${os_arch}")  
	dk_set(TARGET_OS_ARCH "${OS_ARCH}")  
	dk_set(${os_arch} 1)
	dk_set(${OS_ARCH} 1)
	
	### Set DK_PROJECT_DIR ###
	dk_dirname(${TARGET_TRIPLE_DIR} DK_PROJECT_DIR)
	dk_set(DK_PROJECT_DIR ${DK_PROJECT_DIR})
	dk_assert(DK_PROJECT_DIR)

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
	dk_debugFunc(${ARGV})
	
	#dk_getTargetTriple("C:/Users/Administrator/digitalknob/Development/DKApps/DKSDLRml/win_x86_64_clang/Debug")
	dk_getTargetTriple()
endfunction()