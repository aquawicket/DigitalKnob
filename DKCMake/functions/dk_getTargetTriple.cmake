include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_getTargetTriple()
#
#	set the cached target variables 
#

function(dk_getTargetTriple)
	dk_debugFunc(${ARGV})
	
	
	if(NOT CMAKE_SCRIPT_MODE_FILE)
		get_filename_component(CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR} ABSOLUTE)
		dk_printVar(CMAKE_BINARY_DIR)
		
		### Get DK_TARGET_DIR ###
		dk_set(DK_TARGET_DIR ${CMAKE_BINARY_DIR})
		dk_printVar(DK_TARGET_DIR)
		
		### Get DK_TARGET_FOLDER ###
		get_filename_component(DK_TARGET_FOLDER ${DK_TARGET_DIR} NAME)     
		dk_printVar(DK_TARGET_FOLDER)
		
		### Get DK_TARGET_OS_DIR
		### Get DK_TARGET_TYPE ###
		if(${DK_TARGET_DIR} MATCHES "Debug$")
			dk_set(DK_TARGET_TYPE Debug)
			dk_set(DEBUG ON)
			dk_set(RELEASE OFF)
			get_filename_component(DK_TARGET_OS_DIR ${DK_TARGET_DIR} DIRECTORY)
		elseif(${DK_TARGET_DIR} MATCHES "Release$")
			dk_set(DK_TARGET_TYPE Release)
			dk_set(DEBUG OFF)
			dk_set(RELEASE ON)
			get_filename_component(DK_TARGET_OS_DIR ${DK_TARGET_DIR} DIRECTORY)
		else()
			dk_set(DK_TARGET_OS_DIR ${CMAKE_BINARY_DIR})
		endif()
		dk_printVar(DK_TARGET_OS_DIR)
		dk_printVar(DK_TARGET_TYPE)
		
		### Get DK_TARGET_OS_FOLDER
		get_filename_component(DK_TARGET_OS_FOLDER ${DK_TARGET_OS_DIR} NAME)     
		dk_printVar(DK_TARGET_OS_FOLDER)
		
		dk_set(DK_TARGET_OS ${DK_TARGET_OS_FOLDER})
		### Get DK_TARGET_ENV
		if(${DK_TARGET_OS} MATCHES "_clang$")
			dk_set(DK_TARGET_ENV clang)
			string(REPLACE _clang "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		if(${DK_TARGET_OS} MATCHES "_mingw$")
			dk_set(DK_TARGET_ENV mingw)
			string(REPLACE _mingw "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		if(${DK_TARGET_OS} MATCHES "_ucrt$")
			dk_set(DK_TARGET_ENV ucrt)
			string(REPLACE _ucrt "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		if(${DK_TARGET_OS} MATCHES "_msvc$")
			dk_set(DK_TARGET_ENV msvc)
			string(REPLACE _msvc "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		dk_printVar(DK_TARGET_ENV)
		
		### Get DK_TARGET_ARCH
		if(${DK_TARGET_OS} MATCHES "_arm32$")
			dk_set(DK_TARGET_ARCH arm32)
			string(REPLACE _arm32 "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		if(${DK_TARGET_OS} MATCHES "_arm64$")
			dk_set(DK_TARGET_ARCH arm64)
			string(REPLACE _arm64 "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		if(${DK_TARGET_OS} MATCHES "_x86$")
			dk_set(DK_TARGET_ARCH x86)
			string(REPLACE _x86 "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		if(${DK_TARGET_OS} MATCHES "_x86_64$")
			dk_set(DK_TARGET_ARCH x86_64)
			string(REPLACE _x86_64 "" DK_TARGET_OS "${DK_TARGET_OS}")
		endif()
		dk_printVar(DK_TARGET_ARCH)
		
		### Set MSYSTEM
		if(DK_TARGET_ENV)
			dk_toUpper(${DK_TARGET_ENV} DK_TARGET_ENV_UPPER)
			#if(${DK_TARGET_ARCH} MATCHES "arm32")
			#	dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}ARM32")
			#endif()
			if(${DK_TARGET_ARCH} MATCHES "arm64")
				dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}ARM64")	# CLANGARM64
			endif()
			if(${DK_TARGET_ARCH} MATCHES "x86")
				dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}32")		# CLANG32, MINGW32
			endif()
			if(${DK_TARGET_ARCH} MATCHES "x86_64")
				dk_set(MSYSTEM "${DK_TARGET_ENV_UPPER}64")		# CLANG64, MINGW64, UCRT64
			endif()
			dk_printVar(MSYSTEM)
			dk_set(${MSYSTEM} ON)
		endif()
		
		### Get DK_TARGET_OS
		dk_printVar(DK_TARGET_OS)
		
		### Set DK_TARGET_OS_ARCH ###
		dk_set(DK_TARGET_OS_ARCH "${DK_TARGET_OS}_${DK_TARGET_ARCH}")  
		dk_printVar(DK_TARGET_OS_ARCH)

		### Set DK_PROJECT_DIR ###
		get_filename_component(DK_PROJECT_DIR ${DK_TARGET_OS_DIR} DIRECTORY)
		dk_set(DK_PROJECT_DIR ${DK_PROJECT_DIR})
		dk_printVar(DK_PROJECT_DIR)

		### Set OS ###
		#dk_set(OS "${DK_TARGET_OS_ARCH}")
		dk_set(OS "${DK_TARGET_OS_FOLDER}")
		dk_printVar(OS)

		### Set ${OS} variable ON ##
		dk_toUpper(${DK_TARGET_OS} DK_TARGET_OS_UPPER)
		dk_set(${DK_TARGET_OS_UPPER} ON)
		dk_printVar(DK_TARGET_OS_UPPER)

		### Set ARCH variable ON ##
		if(DK_TARGET_ARCH)
			dk_toUpper(${DK_TARGET_ARCH} DK_TARGET_ARCH_UPPER)
		endif()

		if(DK_TARGET_ARCH_UPPER)
			dk_set(${DK_TARGET_ARCH_UPPER} ON)
		endif()
		dk_printVar(DK_TARGET_ARCH_UPPER)

		### Set ${OS_ARCH} variable ON ##
		dk_set(${DK_TARGET_OS_UPPER}_${DK_TARGET_ARCH_UPPER} ON)
		dk_printVar(${DK_TARGET_OS_UPPER}_${DK_TARGET_ARCH_UPPER})

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
		dk_printVar(DEBUG_DIR)
		dk_printVar(RELEASE_DIR)
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)