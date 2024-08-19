include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getTargetTriple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
function(dk_getTargetTriple)
	dk_debugFunc(${ARGV})
	
	if(NOT CMAKE_SCRIPT_MODE_FILE)
		dk_getFullPath(${CMAKE_BINARY_DIR} CMAKE_BINARY_DIR)
		#dk_printVar(CMAKE_BINARY_DIR)
		
		### Get DK_TARGET_DIR ###
		dk_set(DK_TARGET_DIR ${CMAKE_BINARY_DIR})
		
		### Get DK_TARGET_FOLDER ###
		dk_basename(${DK_TARGET_DIR} DK_TARGET_FOLDER)     
		
		### Get DK_TARGET_OS_DIR
		### Get DK_TARGET_TYPE ###
		if(${DK_TARGET_DIR} MATCHES "Debug$")
			dk_set(DK_TARGET_TYPE Debug)
			dk_set(DEBUG ON)
			dk_set(RELEASE OFF)
			dk_dirname(${DK_TARGET_DIR} DK_TARGET_OS_DIR)
		elseif(${DK_TARGET_DIR} MATCHES "Release$")
			dk_set(DK_TARGET_TYPE Release)
			dk_set(DEBUG OFF)
			dk_set(RELEASE ON)
			dk_dirname(${DK_TARGET_DIR} DK_TARGET_OS_DIR)
		else()
			dk_set(DK_TARGET_OS_DIR ${CMAKE_BINARY_DIR})
		endif()
		
		### Get DK_TARGET_OS_FOLDER
		dk_basename(${DK_TARGET_OS_DIR} DK_TARGET_OS_FOLDER)     
		
		dk_set(DK_TARGET_OS ${DK_TARGET_OS_FOLDER})
		### Get DK_TARGET_ENV
		if(${DK_TARGET_OS} MATCHES "_clang$")
			dk_set(DK_TARGET_ENV clang)
			dk_replaceAll("${DK_TARGET_OS}" _clang "" DK_TARGET_OS)
		elseif(${DK_TARGET_OS} MATCHES "_mingw$")
			dk_set(DK_TARGET_ENV mingw)
			dk_replaceAll("${DK_TARGET_OS}" _mingw "" DK_TARGET_OS)
		elseif(${DK_TARGET_OS} MATCHES "_ucrt$")
			dk_set(DK_TARGET_ENV ucrt)
			dk_replaceAll("${DK_TARGET_OS}" _ucrt "" DK_TARGET_OS)
		elseif(${DK_TARGET_OS} MATCHES "_msvc$")
			dk_set(DK_TARGET_ENV msvc)
			dk_replaceAll("${DK_TARGET_OS}" _msvc "" DK_TARGET_OS)
		else()
			dk_warning("The CMAKE_BINARY_DIR:${CMAKE_BINARY_DIR} does not contain info to set DK_TARGET_ENV")
		endif()
		
		### Get DK_TARGET_ARCH
		if(${DK_TARGET_OS} MATCHES "_arm64$")
			dk_set(DK_TARGET_ARCH arm64)
			dk_replaceAll("${DK_TARGET_OS}" _arm64 "" DK_TARGET_OS)
		elseif(${DK_TARGET_OS} MATCHES "_arm32$")
			dk_set(DK_TARGET_ARCH arm32)
			dk_replaceAll("${DK_TARGET_OS}" _arm32 "" DK_TARGET_OS)
		elseif(${DK_TARGET_OS} MATCHES "_x86_64$")
			dk_set(DK_TARGET_ARCH x86_64)
			dk_replaceAll("${DK_TARGET_OS}" _x86_64 "" DK_TARGET_OS)
		elseif(${DK_TARGET_OS} MATCHES "_x86$")
			dk_set(DK_TARGET_ARCH x86)
			dk_replaceAll("${DK_TARGET_OS}" _x86 "" DK_TARGET_OS)
		else()
			dk_error("The CMAKE_BINARY_DIR:${CMAKE_BINARY_DIR} does not contain info to set DK_TARGET_ARCH")
		endif()
		
		### Set MSYSTEM
		if(DK_TARGET_ENV)
			dk_toUpper(${DK_TARGET_ENV} DK_TARGET_ENV_UPPER)
			if(${DK_TARGET_ARCH} MATCHES "arm64")
				dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}ARM64")	# CLANGARM64
			elseif(${DK_TARGET_ARCH} MATCHES "arm32")
			#	dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}ARM32")
			elseif(${DK_TARGET_ARCH} MATCHES "x86_64")
				dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}64")		# CLANG64, MINGW64, UCRT64
			elseif(${DK_TARGET_ARCH} MATCHES "x86")
				dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}32")		# CLANG32, MINGW32
			else()
				dk_error("The CMAKE_BINARY_DIR:${CMAKE_BINARY_DIR} does not contain info to set MSYSTEM")
			endif()
			dk_set(${MSYSTEM} ON)
		endif()
		
		### Get DK_TARGET_OS
		#dk_printVar(DK_TARGET_OS)
		
		### Set DK_TARGET_OS_ARCH ###
		dk_set(DK_TARGET_OS_ARCH "${DK_TARGET_OS}_${DK_TARGET_ARCH}")  

		### Set DK_PROJECT_DIR ###
		dk_dirname(${DK_TARGET_OS_DIR} DK_PROJECT_DIR)
		dk_set(DK_PROJECT_DIR ${DK_PROJECT_DIR})

		### Set OS ###
		#dk_set(OS "${DK_TARGET_OS_ARCH}")
		dk_set(OS "${DK_TARGET_OS_FOLDER}")

		### Set ${OS} variable ON ##
		dk_toUpper(${DK_TARGET_OS} DK_TARGET_OS_UPPER)
		dk_set(${DK_TARGET_OS_UPPER} ON)

		### Set ARCH variable ON ##
		if(DK_TARGET_ARCH)
			dk_toUpper(${DK_TARGET_ARCH} DK_TARGET_ARCH_UPPER)
		endif()

		if(DK_TARGET_ARCH_UPPER)
			dk_set(${DK_TARGET_ARCH_UPPER} ON)
		endif()

		### Set ${OS_ARCH} variable ON ##
		dk_set(${DK_TARGET_OS_UPPER}_${DK_TARGET_ARCH_UPPER} ON)

		### Set DEBUG_DIR and RELEASE_DIR variables
		if(${DK_TARGET_OS} MATCHES "ios")
			dk_set(DEBUG_DIR Debug-iphoneos)
			dk_set(RELEASE_DIR Release-iphoneos)
		elseif(${DK_TARGET_OS} MATCHES "iossim")
			dk_set(DEBUG_DIR Debug-iphonesimulator)
			dk_set(RELEASE_DIR Release-iphonesimulator)
		else()
			dk_set(DEBUG_DIR Debug)
			dk_set(RELEASE_DIR Release)
		endif()
		
		### Set DK_TARGET_TRIPLE ###
		if(DK_TARGET_ENV)
			dk_set(DK_TARGET_TRIPLE "${DK_TARGET_OS}_${DK_TARGET_ARCH}_${DK_TARGET_ENV}")
		else()
			dk_set(DK_TARGET_TRIPLE "${DK_TARGET_OS}_${DK_TARGET_ARCH}")
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_getTargetTriple()
endfunction()