#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_target_triple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	If the CMAKE_BINARY_DIR is missing the <OS> or the <ARCH>, dk_target_triple_SET will be called to get those variables
#
#	os   				= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	OS   				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	arch				= arm32, arm64, x86, x86_64
#	ARCH				= ARM32, ARM64, X86, X86_64
#	env					= clang, cosmopolitan, mingw, msvc, ucrt
#	ENV					= CLANG, COSMOPOLITAN, MINGW, MSVC, UCRT
#   <os>_<arch>			= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
#   <os>_<arch>_<env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
#
function(dk_target_triple)
	dk_debugFunc(0 1)

	set(default_target_env "clang")
	
	### Get TARGET_DIR ###
	dk_getFullPath("${CMAKE_BINARY_DIR}" Target_Dir)
	dk_toLower(${Target_Dir} target_dir)
	dk_toUpper(${target_dir} TARGET_DIR)
	dk_printVar(Target_Dir)								# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang/Debug

	### Set target_type / TARGET_TYPE ###
	if(Target_Dir MATCHES "Debug")	
		### Get DEBUG ###
		dk_set(target_type DEBUG)						# 	   target_type = DEBUG
		dk_set(${target_type} 1)						# 			  DEBUG = 1	
		dk_dirname(${Target_Dir} Target_Triple_Dir)		# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang

	elseif(Target_Dir MATCHES "Release")
		### Get RELEASE ###
		dk_set(target_type RELEASE)					# 	   target_type = RELEASE
		dk_set(${target_type} 1)						#			RELEASE = 1	
		dk_dirname(${Target_Dir} Target_Triple_Dir)		# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	endif()
		if( (target_dir MATCHES "android")		OR
			(target_dir MATCHES "emscripten")	OR
			(target_dir MATCHES "ios")			OR
			(target_dir MATCHES "iossim")		OR
			(target_dir MATCHES "linux")		OR
			(target_dir MATCHES "mac")			OR
			(target_dir MATCHES "raspberry")	OR
			(target_dir MATCHES "windows")		OR
			(target_dir MATCHES "cosmopolitan") )
			dk_set(Target_Triple_Dir ${Target_Dir})			# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
		else()
			dk_target_triple_SET()
			dk_set(Target_Triple_Dir ${Target_Dir}/${Triple})
		endif()

	if(NOT EXISTS ${Target_Triple_Dir})
		dk_warning("Target_Triple_Dir:${Target_Triple_Dir} does not exits.")
		dk_debug("Creating directory . . .${Target_Triple_Dir} ")
		dk_makeDirectory(${Target_Triple_Dir})
	endif()
	dk_assertPath(Target_Triple_Dir)
		
	### Set DK_Project_Dir ###
	dk_dirname(${Target_Triple_Dir} DK_Project_Dir)
	dk_set(DK_Project_Dir ${DK_Project_Dir})
	dk_assertPath(DK_Project_Dir)

	### Set triple/TRIPLE, <os>_<arch>_<env>/<OS>_<ARCH>_<ENV> ###
	dk_basename(${Target_Triple_Dir} Triple)	# 			Triple 	= Win_x86_64_Clang
	dk_toLower(${Triple} triple)				# 			 triple	= win_x86_64_clang
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
		dk_set(Os Android)
	elseif(triple MATCHES "emscripten")
		dk_set(Os Emscripten)
	elseif(triple MATCHES "iossim")
		dk_set(Os IosSim)
	elseif(triple MATCHES "ios")
		dk_set(Os Ios)
	elseif(triple MATCHES "linux")
		dk_set(Os Linux)
	elseif(triple MATCHES "mac")
		dk_set(Os Mac)
	elseif(triple MATCHES "raspberry")
		dk_set(Os Raspberry)
	elseif(triple MATCHES "windows")
		dk_set(Os Windows)
	elseif(triple MATCHES "win")
		dk_set(Os Win)
	elseif(triple MATCHES "cosmopolitan")
		dk_set(Os Cosmopolitan)	
	else()
		dk_error("The target triple:${triple} does not contain a valid os")
		dk_unset(triple)
		dk_unset(TRIPLE)
		dk_target_triple_SET()
	endif()
	if(Os)
		dk_toLower(${Os} os)
		dk_toUpper(${os} OS)
		dk_set(os ${os})
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
		dk_set(Arch Arm64)
	elseif(triple MATCHES "arm32")
		dk_set(Arch Arm32)
	elseif(triple MATCHES "x86_64")
		dk_set(Arch X86_64)
	elseif(triple MATCHES "x86")
		dk_set(Arch X86)
	elseif(triple MATCHES "cosmopolitan")
		dk_set(Arch Cosmopolitan)	
	else()
		dk_warning("The target triple:${triple} does not contain a valid arch")
		dk_target_triple_SET()
	endif()
	if(Arch)
		dk_toLower(${Arch} arch)
		dk_toUpper(${Arch} ARCH)
		dk_set(arch ${arch})
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
		dk_set(Env Clang)
	elseif(triple MATCHES "mingw")
		dk_set(Env Mingw)
	elseif(triple MATCHES "ucrt")
		dk_set(Env Ucrt)
	elseif(triple MATCHES "msvc")
		dk_set(Env Msvc)
	elseif(triple MATCHES "cosmopolitan")
		dk_set(Env Cosmopolitan)
	else()
		dk_warning("The target triple:${triple} does not contain a valid env")
		dk_set(Env ${default_target_env})
	endif()
	if(Env)
		dk_toLower(${Env} env)
		dk_toUpper(${env} ENV)
		dk_set(env ${env})
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
