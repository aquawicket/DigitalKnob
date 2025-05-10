#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_Target_Tuple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  Win_X86_64_Clang
#
#	If the CMAKE_BINARY_DIR is missing the <Target_Os> or the <Target_Arch>, dk_Target_Tuple_SET will be called to get those variables
#
#   <Target_Os>_<Target_Arch>				= Android_Arm64, Emscripten_Arm64, Ios_Arm64, Iossim_Arm64, Linux_Arm64, Mac_Arm64, Raspberry_Arm64, Windows_Arm64
#   <Target_Os>_<Target_Arch>_<Target_Env>	= Android_Arm64_Clang, Emscripten_Arm64_Clang, Ios_Arm64_Clang, Iossim_Arm64_Clang, Linux_Arm64_Clang, Mac_Arm64_Clang, Raspberry_Arm64_Clang, Windows_Arm64_Clang
#
function(dk_Target_Tuple)
	dk_debugFunc(0 1)
	message("dk_Target_Tuple(${ARGV})")
	
	### Get Target_Dir ###
	dk_getFullPath("${CMAKE_BINARY_DIR}" Target_Dir)	# Target_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang/Debug														
	message("")
	
	### Set Target_Tuple ###
	if(Target_Dir MATCHES "Release")
		dk_set(Target_Tuple Release)					# Target_Tuple = Release
	else()
		dk_set(Target_Tuple Debug)						# Target_Tuple = Debug (DEFAULT)
	endif()												
	dk_set(${Target_Tuple} 1)							# Debug		  = 1												
	
	### Set Target_Tuple_Dir ###
	dk_dirname(${Target_Dir} Target_Tuple_Dir)											
	message("")
	
	if( (target_dir MATCHES "Android")		OR
		(target_dir MATCHES "Emscripten")	OR
		(target_dir MATCHES "Ios")			OR
		(target_dir MATCHES "Iossim")		OR
		(target_dir MATCHES "Linux")		OR
		(target_dir MATCHES "Mac")			OR
		(target_dir MATCHES "Raspberry")	OR
		(target_dir MATCHES "Win")			OR
		(target_dir MATCHES "Cosmopolitan") )
		dk_set(Target_Tuple_Dir ${Target_Dir})
	else()
		message("######calling dk_Target_Tuple_SET()#####")
		dk_Target_Tuple_SET()
		message("######returned from dk_Target_Tuple_SET()#####")
		#dk_printVar(Target_Tuple)
		dk_set(Target_Tuple_Dir ${Target_Dir}/${Target_Tuple})
	endif()
	
	#dk_printVar(Target_Tuple_Dir)						# Target_Tuple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	
	if(NOT EXISTS ${Target_Tuple_Dir})
		dk_warning("Target_Tuple_Dir:${Target_Tuple_Dir} does not exits. Creating directory . . .")
		dk_mkdir(${Target_Tuple_Dir})
	endif()
	dk_assertPath(Target_Tuple_Dir)
	
	### Set DK_Project_Dir ###
	dk_dirname(${Target_Tuple_Dir} DK_Project_Dir)
	dk_set(DK_Project_Dir ${DK_Project_Dir})
	dk_assertPath(DK_Project_Dir)
	
	### Set Target_Tuple
	if(NOT DEFINED Target_Tuple)
		dk_basename(${Target_Tuple_Dir} Target_Tuple)	# Target_Tuple = Win_x86_64_Clang
	endif()												
	dk_set(${Target_Tuple} 1)							# Win_X86_64_Clang = 1										

	### Set Target_Os / <Target_Os>_Target
		if(Target_Tuple MATCHES "Android")
		dk_set(Target_Os Android)
	elseif(Target_Tuple MATCHES "Emscripten")
		dk_set(Target_Os Emscripten)
	elseif(Target_Tuple MATCHES "Iossim")
		dk_set(Target_Os IosSim)
	elseif(Target_Tuple MATCHES "Ios")
		dk_set(Target_Os Ios)
	elseif(Target_Tuple MATCHES "Linux")
		dk_set(Target_Os Linux)
	elseif(Target_Tuple MATCHES "Mac")
		dk_set(Target_Os Mac)
	elseif(Target_Tuple MATCHES "Raspberry")
		dk_set(Target_Os Raspberry)
	elseif(Target_Tuple MATCHES "Windows")
		dk_set(Target_Os Windows)
	elseif(Target_Tuple MATCHES "Win")
		dk_set(Target_Os Win)
	elseif(Target_Tuple MATCHES "Cosmopolitan")
		dk_set(Target_Os Cosmopolitan)	
	else()
		dk_error("The target Target_Tuple:'${Target_Tuple}' does not contain a valid Target_Os")
		dk_unset(Target_Tuple)
		message("######calling dk_Target_Tuple_SET()#####")
		dk_Target_Tuple_SET()
		message("######returned from dk_Target_Tuple_SET()#####")
	endif()
	if(Target_Os)
		dk_set(Target_Os ${Target_Os})
		dk_set(${Target_Os} 1)
	endif()

	### Get target_arch / Target_Arch
		if(Target_Tuple MATCHES "Arm64")
		dk_set(Target_Arch Arm64)
	elseif(Target_Tuple MATCHES "Arm32")
		dk_set(Target_Arch Arm32)
	elseif(Target_Tuple MATCHES "X86_64")
		dk_set(Target_Arch X86_64)
	elseif(Target_Tuple MATCHES "X86")
		dk_set(Target_Arch X86)
	elseif(Target_Tuple MATCHES "Cosmopolitan")
		dk_set(Target_Arch Cosmopolitan)	
	else()
		dk_warning("The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Arch")
		message("######calling dk_Target_Tuple_SET()#####")
		dk_Target_Tuple_SET()
		message("######returned from dk_Target_Tuple_SET()#####")
	endif()
	if(Target_Arch)
		dk_set(${Target_Arch} 1)
	endif()

	### Set evn / TARGET_ENV 
		if(Target_Tuple MATCHES "Clang")
		dk_set(Target_Env Clang)
	elseif(Target_Tuple MATCHES "Mingw")
		dk_set(Target_Env Mingw)
	elseif(Target_Tuple MATCHES "Ucrt")
		dk_set(Target_Env Ucrt)
	elseif(Target_Tuple MATCHES "Msvc")
		dk_set(Target_Env Msvc)
	elseif(Target_Tuple MATCHES "Cosmopolitan")
		dk_set(Target_Env Cosmopolitan)
	else()
		dk_warning("The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Env")
		dk_set(Target_Env ${Default_Target_Env})
	endif()
	if(Target_Env)
		dk_set(Target_Env ${Target_Env})
		dk_set(${Target_Env} 1)
	endif()
	dk_depend(${target_env})
	
	### Set MSYSTEM
	if(${Target_Env})
		dk_validate(MSYSTEM "dk_MSYSTEM()")
	endif()
	
	### Set target_os_arch / TARGET_OS_ARCH ###
	dk_set(Target_Os_Arch "${Target_Os}_${Target_Arch}")
	dk_set(${Target_Os_Arch} 1)

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

	dk_Target_Tuple()
endfunction()
