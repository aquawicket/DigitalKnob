#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_target_triple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	If the CMAKE_BINARY_DIR is missing the <TARGET_OS> or the <TARGET_ARCH>, dk_target_triple_SET will be called to get those variables
#
#	target_os   							= android, emscripten, ios, iossim, linux, mac, raspberry, windows
#	Target_Os   							= Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows 
#	TARGET_OS   							= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	target_arch								= arm32, arm64, x86, x86_64
#	Target_Arch								= Arm32, Arm64, X86, X86_64
#	TARGET_ARCH								= ARM32, ARM64, X86, X86_64
#	target_env								= clang, cosmopolitan, mingw, msvc, ucrt
#	Target_Env								= Clang, Cosmopolitan, Mingw, Msvc, Ucrt
#	TARGET_ENV								= CLANG, COSMOPOLITAN, MINGW, MSVC, UCRT
#   <target_os>_<target_arch>				= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
#   <target_os>_<target_arch>_<target_env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
#
function(dk_target_triple)
	dk_debugFunc(0 1)
	message("dk_target_triple(${ARGV})")

	#set(default_target_os "${host_os}")
	#set(default_target_arch "${host_arch}")
	set(default_target_env "clang")
	message("")
	
	### Get Target_Dir ###
	dk_getFullPath("${CMAKE_BINARY_DIR}" Target_Dir)
	dk_toLower(${Target_Dir} target_dir)
	dk_toUpper(${Target_Dir} TARGET_DIR)
	dk_printVar(target_dir)								# target_dir = c:/users/administrator/digitalknob/development/dkcpp/apps/dksample/win_x86_64_clang/debug
	dk_printVar(Target_Dir)								# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang/Debug
	dk_printVar(TARGET_DIR)								# TARGET_DIR = C:/USERS/ADMINISTRATOR/DIGITALKNOB/DEVELOPMENT/DKCPP/APPS/DKSAMPLE/WIN_X86_64_CLANG/DEBUG
	message("")

message("${CMAKE_CURRENT_LIST_LINE}")	
	### Set Target_Type ###
	if(Target_Dir MATCHES "Release")
		dk_set(Target_Type Release)						# Target_Type = Release
	else()
		dk_set(Target_Type Debug)						# Target_Type = Debug (DEFAULT)
	endif()
	dk_toLower(${Target_Type} target_type)
	dk_toUpper(${Target_Type} TARGET_TYPE)
	dk_set(${TARGET_TYPE} 1)
	dk_printVar(target_type)							# target_type = debug
	dk_printVar(Target_Type)							# Target_Type = Debug
	dk_printVar(TARGET_TYPE)							# TARGET_TYPE = DEBUG
	dk_printVar(${TARGET_TYPE})							# DEBUG		  = 1
	
message("${CMAKE_CURRENT_LIST_LINE}")		
	### Set Target_Triple_Dir ###
	dk_dirname(${Target_Dir} Target_Triple_Dir)			
	dk_toLower(${Target_Triple_Dir} target_triple_dir)	
	dk_toUpper(${Target_Triple_Dir} TARGET_TRIPLE_DIR)	
	dk_printVar(target_triple_dir)						# target_triple_dir = c:/users/administrator/digitalknob/development/dkcpp/apps/dksample/win_x86_64_clang
	dk_printVar(Target_Triple_Dir)						# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	dk_printVar(TARGET_TRIPLE_DIR)						# TARGET_TRIPLE_DIR = C:/USERS/ADMINISTRATOR/DIGITALKNOB/DEVELOPMENT/DKCPP/APPS/DKSAMPLE/WIN_X86_64_CLANG
	message("")
	
message("${CMAKE_CURRENT_LIST_LINE}")		
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
		dk_printVar(Target_Triple)
		dk_printVar(target_triple)
		dk_printVar(TARGET_TRIPLE)
		dk_set(Target_Triple_Dir ${Target_Dir}/${Target_Triple})
	endif()
	dk_printVar(Target_Triple_Dir)						# Target_Triple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	dk_printVar(target_triple_dir)						# target_triple_dir = c:/users/administrator/digitalknob/development/dkcpp/apps/dksample/win_x86_64_clang
	dk_printVar(TARGET_TRIPLE_DIR)						# TARGET_TRIPLE_DIR = C:/USERS/ADMINISTRATOR/DIGITALKNOB/DEVELOPMENT/DKCPP/APPS/DKSAMPLE/WIN_X86_64_CLANG
	message("")
	
message("${CMAKE_CURRENT_LIST_LINE}")	
	if(NOT EXISTS ${Target_Triple_Dir})
		dk_warning("Target_Triple_Dir:${Target_Triple_Dir} does not exits.")
		dk_debug("Creating directory . . .${Target_Triple_Dir} ")
		dk_mkdir(${Target_Triple_Dir})
	endif()
	dk_assertPath(Target_Triple_Dir)
	
message("${CMAKE_CURRENT_LIST_LINE}")		
	### Set DK_Project_Dir ###
	dk_dirname(${Target_Triple_Dir} DK_Project_Dir)
	dk_set(DK_Project_Dir ${DK_Project_Dir})
	dk_printVar(DK_Project_Dir)	
	dk_assertPath(DK_Project_Dir)
	
message("${CMAKE_CURRENT_LIST_LINE}")	
	### Set Target_Triple
	if(NOT DEFINED Target_Triple)
		dk_basename(${Target_Triple_Dir} Target_Triple)		# Target_Triple = Win_x86_64_Clang
	endif()
	dk_toLower(${Target_Triple} target_triple)			
	dk_toUpper(${Target_Triple} TARGET_TRIPLE)		
	dk_set(target_triple ${target_triple})			# Globalize the variable
	dk_set(Target_Triple ${Target_Triple})			# Globalize the variable
	dk_set(TARGET_TRIPLE ${TARGET_TRIPLE})			# Globalize the variable
	dk_set(${target_triple} 1)
	dk_set(${Target_Triple} 1)
	dk_set(${TARGET_TRIPLE} 1)
	dk_printVar(target_triple)						# target_triple	= win_x86_64_clang
	dk_printVar(Target_Triple)						# Target_Triple	= Win_X86_64_Clang
	dk_printVar(TARGET_TRIPLE)						# TARGET_TRIPLE	= WIN_X86_64_CLANG
	dk_printVar(${target_triple})					# win_x86_64_clang = 1
	dk_printVar(${Target_Triple})					# Win_X86_64_Clang = 1
	dk_printVar(${TARGET_TRIPLE})					# WIN_X86_64_CLANG = 1

message("${CMAKE_CURRENT_LIST_LINE}")	
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
		dk_error("The target target_triple:'${target_triple}' does not contain a valid target_os")
		dk_unset(target_triple)
		dk_unset(TARGET_TRIPLE)
		message("######calling dk_target_triple_SET()#####")
		dk_target_triple_SET()
		message("######returned from dk_target_triple_SET()#####")
	endif()
	if(Target_Os)
		dk_toLower(${Target_Os} target_os)
		dk_toUpper(${target_os} TARGET_OS)
		dk_set(target_os ${target_os})
		dk_set(TARGET_OS ${TARGET_OS})
		dk_set(${target_os} 1)
		dk_set(${TARGET_OS} 1)
		#dk_set(${target_os}_target 1)
		#dk_set(${TARGET_OS}_TARGET 1)
	endif()

message("${CMAKE_CURRENT_LIST_LINE}")	
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
		dk_toLower(${Target_Arch} target_arch)
		dk_toUpper(${Target_Arch} TARGET_ARCH)
		dk_set(target_arch ${target_arch})
		dk_set(TARGET_ARCH ${TARGET_ARCH})
		dk_set(${target_arch} 1)
		dk_set(${TARGET_ARCH} 1)
		#dk_set(${target_arch}_target 1)
		#dk_set(${TARGET_ARCH}_TARGET 1)
	endif()

message("${CMAKE_CURRENT_LIST_LINE}")	
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
		dk_set(Target_Env ${default_target_env})
	endif()
	if(Target_Env)
		dk_toLower(${Target_Env} target_env)
		dk_toUpper(${target_env} TARGET_ENV)
		dk_set(target_env ${target_env})
		dk_set(TARGET_ENV ${TARGET_ENV})
		dk_set(${target_env} 1)
		dk_set(${TARGET_ENV} 1)
		#dk_set(${target_env}_target 1)
		#dk_set(${TARGET_ENV}_TARGET 1)
	endif()

message("${CMAKE_CURRENT_LIST_LINE}")	
	### Set MSYSTEM
	if(${TARGET_ENV})
		dk_validate(MSYSTEM "dk_MSYSTEM()")
	endif()
	
message("${CMAKE_CURRENT_LIST_LINE}")		
	### Set target_os_arch / TARGET_OS_ARCH ###
	dk_set(target_os_arch "${target_os}_${target_arch}")
	dk_set(TARGET_OS_ARCH "${TARGET_OS}_${TARGET_ARCH}")
	#dk_set(target_os_arch "${target_os_arch}")
	#dk_set(TARGET_OS_ARCH "${TARGET_OS_ARCH}")
	dk_set(${target_os_arch} 1)
	dk_set(${TARGET_OS_ARCH} 1)
	#dk_set(${target_os_arch}_target 1)
	#dk_set(${TARGET_OS_ARCH}_TARGET 1)

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
