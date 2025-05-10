#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_target_triple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  Win_X86_64_Clang
#
#	If the CMAKE_BINARY_DIR is missing the <Target_Os> or the <Target_Arch>, dk_Target_Triple_SET will be called to get those variables
#
#	Target_Os   							= Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#	Target_Arch								= Arm32, Arm64, X86, X86_64
#	Target_Env								= Clang, Cosmopolitan, Mingw, Msvc, Ucrt
#   <Target_Os>_<Target_Arch>				= Android_Arm64, Emscripten_Arm64, Ios_Arm64, Iossim_Arm64, Linux_Arm64, Mac_Arm64, Raspberry_Arm64, Windows_Arm64
#   <Target_Os>_<Target_Arch>_<Target_Env>	= Android_Arm64_Clang, Emscripten_Arm64_Clang, Ios_Arm64_Clang, Iossim_Arm64_Clang, Linux_Arm64_Clang, Mac_Arm64_Clang, Raspberry_Arm64_Clang, Windows_Arm64_Clang
#
function(dk_target_triple)
	dk_debugFunc(0 1)
	message("dk_target_triple(${ARGV})")

	#set(Default_Target_Os "${Host_Os}")
	#set(Default_Target_Arch "${Host_Arch}")
	set(Default_Target_Env "Clang")
	message("")
	
	### Get Target_Dir ###
	dk_getFullPath("${CMAKE_BINARY_DIR}" Target_Dir)
	#d_k_toCamel(${Target_Dir} Target_Dir)				# Target_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang/Debug
	#dk_printVar(Target_Dir)															
	message("")
	
	### Set Target_Type ###
	if(Target_Dir MATCHES "Release")
		dk_set(Target_Type Release)						# Target_Type = Release
	else()
		dk_set(Target_Type Debug)						# Target_Type = Debug (DEFAULT)
	endif()
	#d_k_toCamel(${Target_Type} Target_Type)			# Target_Type = Debug
	#dk_printVar(Target_Type)													
	dk_set(${Target_Type} 1)							# Debug		  = 1
	#dk_printVar(${Target_Type})													
	
	### Set Target_Triple_Dir ###
	dk_dirname(${Target_Dir} Target_Triple_Dir)	
	#d_k_toCamel(${Target_Triple_Dir} Target_Triple_Dir)	# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang	
	#dk_printVar(Target_Triple_Dir)											
	message("")
	
	if( (target_dir MATCHES "android")		OR
		(target_dir MATCHES "emscripten")	OR
		(target_dir MATCHES "ios")			OR
		(target_dir MATCHES "iossim")		OR
		(target_dir MATCHES "linux")		OR
		(target_dir MATCHES "mac")			OR
		(target_dir MATCHES "raspberry")	OR
		(target_dir MATCHES "win")			OR
		(target_dir MATCHES "cosmopolitan") )
		dk_set(Target_Triple_Dir ${Target_Dir})
	else()
		message("######calling dk_target_triple_SET()#####")
		dk_target_triple_SET()
		message("######returned from dk_target_triple_SET()#####")
		#dk_printVar(Target_Triple)
		dk_set(Target_Triple_Dir ${Target_Dir}/${Target_Triple})
	endif()
	
	#dk_printVar(Target_Triple_Dir)						# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	
	if(NOT EXISTS ${Target_Triple_Dir})
		dk_warning("Target_Triple_Dir:${Target_Triple_Dir} does not exits. Creating directory . . .")
		dk_mkdir(${Target_Triple_Dir})
	endif()
	dk_assertPath(Target_Triple_Dir)
	
	### Set DK_Project_Dir ###
	dk_dirname(${Target_Triple_Dir} DK_Project_Dir)
	dk_set(DK_Project_Dir ${DK_Project_Dir})
	#dk_printVar(DK_Project_Dir)	
	dk_assertPath(DK_Project_Dir)
	
	### Set Target_Triple
	if(NOT DEFINED Target_Triple)
		dk_basename(${Target_Triple_Dir} Target_Triple)	# Target_Triple = Win_x86_64_Clang
	endif()
	#d_k_toCamel(${Target_Triple} Target_Triple)		# Target_Triple	= Win_X86_64_Clang
	dk_set(Target_Triple ${Target_Triple})				# Globalize the variable						
	#dk_printVar(Target_Triple)													
	dk_set(${Target_Triple} 1)							# Win_X86_64_Clang = 1
	#dk_printVar(${Target_Triple})											

	### Set target_os / TARGET_OS / <target_os>_target / <TARGET_OS>_TARGET
		if(target_triple MATCHES "android")
		dk_set(Target_Os Android)
	elseif(target_triple MATCHES "emscripten")
		dk_set(Target_Os Emscripten)
	elseif(target_triple MATCHES "iossim")
		dk_set(Target_Os IosSim)
	elseif(target_triple MATCHES "ios")
		dk_set(Target_Os Ios)
	elseif(target_triple MATCHES "linux")
		dk_set(Target_Os Linux)
	elseif(target_triple MATCHES "mac")
		dk_set(Target_Os Mac)
	elseif(target_triple MATCHES "raspberry")
		dk_set(Target_Os Raspberry)
	elseif(target_triple MATCHES "windows")
		dk_set(Target_Os Windows)
	elseif(target_triple MATCHES "win")
		dk_set(Target_Os Win)
	elseif(target_triple MATCHES "cosmopolitan")
		dk_set(Target_Os Cosmopolitan)	
	else()
		dk_error("The target Target_Triple:'${Target_Triple}' does not contain a valid Target_Os")
		dk_unset(Target_Triple)
		dk_unset(target_triple)
		dk_unset(TARGET_TRIPLE)
		message("######calling dk_target_triple_SET()#####")
		dk_target_triple_SET()
		message("######returned from dk_target_triple_SET()#####")
	endif()
	if(Target_Os)
		#d_k_toCamel(${Target_Os} Target_Os)
		dk_toLower(${Target_Os} target_os)
		dk_toUpper(${target_os} TARGET_OS)
		dk_set(Target_Os ${Target_Os})
		dk_set(target_os ${target_os})
		dk_set(TARGET_OS ${TARGET_OS})
		dk_set(${Target_Os} 1)
		dk_set(${target_os} 1)
		dk_set(${TARGET_OS} 1)
	endif()

	### Get target_arch / TARGET_ARCH
		if(target_triple MATCHES "arm64")
		dk_set(Target_Arch Arm64)
	elseif(target_triple MATCHES "arm32")
		dk_set(Target_Arch Arm32)
	elseif(target_triple MATCHES "x86_64")
		dk_set(Target_Arch X86_64)
	elseif(target_triple MATCHES "x86")
		dk_set(Target_Arch X86)
	elseif(target_triple MATCHES "cosmopolitan")
		dk_set(Target_Arch Cosmopolitan)	
	else()
		dk_warning("The target target_triple:${target_triple} does not contain a valid target_arch")
		message("######calling dk_target_triple_SET()#####")
		dk_target_triple_SET()
		message("######returned from dk_target_triple_SET()#####")
	endif()
	if(Target_Arch)
		#d_k_toCamel(${Target_Arch} Target_Arch)
		dk_toLower(${Target_Arch} target_arch)
		dk_toUpper(${Target_Arch} TARGET_ARCH)
		dk_set(Target_Arch ${Target_Arch})
		dk_set(target_arch ${target_arch})
		dk_set(TARGET_ARCH ${TARGET_ARCH})
		dk_set(${Target_Arch} 1)
		dk_set(${target_arch} 1)
		dk_set(${TARGET_ARCH} 1)
	endif()

	### Set evn / TARGET_ENV 
		if(target_triple MATCHES "clang")
		dk_set(Target_Env Clang)
	elseif(target_triple MATCHES "mingw")
		dk_set(Target_Env Mingw)
	elseif(target_triple MATCHES "ucrt")
		dk_set(Target_Env Ucrt)
	elseif(target_triple MATCHES "msvc")
		dk_set(Target_Env Msvc)
	elseif(target_triple MATCHES "cosmopolitan")
		dk_set(Target_Env Cosmopolitan)
	else()
		dk_warning("The target target_triple:${target_triple} does not contain a valid target_env")
		dk_set(Target_Env ${Default_Target_Env})
	endif()
	if(Target_Env)
		#d_k_toCamel(${Target_Env} Target_Env)
		dk_toLower(${Target_Env} target_env)
		dk_toUpper(${target_env} TARGET_ENV)
		dk_set(Target_Env ${Target_Env})
		dk_set(target_env ${target_env})
		dk_set(TARGET_ENV ${TARGET_ENV})
		dk_set(${Target_Env} 1)
		dk_set(${target_env} 1)
		dk_set(${TARGET_ENV} 1)
	endif()
	dk_depend(${target_env})
	
	### Set MSYSTEM
	if(${Target_Env})
		dk_validate(MSYSTEM "dk_MSYSTEM()")
	endif()
	
	### Set target_os_arch / TARGET_OS_ARCH ###
	dk_set(Target_Os_Arch "${Target_Os}_${Target_Arch}")
	dk_set(target_os_arch "${target_os}_${target_arch}")
	dk_set(TARGET_OS_ARCH "${TARGET_OS}_${TARGET_ARCH}")
	dk_set(${Target_Os_Arch} 1)
	dk_set(${target_os_arch} 1)
	dk_set(${TARGET_OS_ARCH} 1)

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
