include_guard()

###############################################################################
# dk_printSettings()
#
#	TODO
#
#	https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html
#
function(dk_printSettings)
	DKDEBUGFUNC(${ARGV})
	
	dk_buildLog("#############  DigitalKnob  ############")
	dk_buildLog(DKBRANCH						PRINTVAR)
	dk_buildLog(DIGITALKNOB_DIR					PRINTVAR)
	dk_buildLog(DKTOOLS_DIR						PRINTVAR)
	dk_buildLog(DKBRANCH_DIR					PRINTVAR)
	dk_buildLog(DK3RDPARTY_DIR					PRINTVAR)
	dk_buildLog(DKIMPORTS_DIR					PRINTVAR)
	dk_buildLog(DKAPPS_DIR						PRINTVAR)
	dk_buildLog(DKPLUGINS_DIR					PRINTVAR)
	dk_buildLog(BUILD_DIR						PRINTVAR)
	
	dk_buildLog("#################  CMAKE VARIABLES  ################")
	#dk_getCmakeCommandLine(CMAKE_COMMAND_LINE)
	dk_buildLog(CMAKE_COMMAND_LINE				PRINTVAR)
	dk_buildLog(CMAKE_COMMAND					PRINTVAR)
	dk_buildLog(CMAKE_EXE						PRINTVAR)
	dk_buildLog(CMAKE_VERSION					PRINTVAR)
	
	dk_buildLog("#################  HOST VARIABLES  ################")
	dk_buildLog(CMAKE_HOST_SYSTEM_NAME			PRINTVAR)
	dk_buildLog(CMAKE_HOST_SYSTEM_VERSION		PRINTVAR)
	dk_buildLog(CMAKE_HOST_SYSTEM_PROCESSOR   	PRINTVAR)
	dk_buildLog(CMAKE_LIBRARY_ARCHITECTURE    	PRINTVAR)
	dk_buildLog(CMAKE_CPP_COMPILER_ID         	PRINTVAR)
	dk_buildLog(CMAKE_CXX_COMPILER_ID         	PRINTVAR)
	dk_buildLog(ENV{USERNAME}                 	PRINTVAR)
	dk_buildLog(ENV{USER}						PRINTVAR)
	#dk_buildLog(ENV{PATH}						PRINTVAR)
	execute_process(COMMAND uname OUTPUT_VARIABLE UNAME OUTPUT_STRIP_TRAILING_WHITESPACE)
	dk_buildLog(UNAME							PRINTVAR)
	dk_buildLog(MINGW							PRINTVAR)
	dk_buildLog(MSYS							PRINTVAR)
	dk_buildLog(MSVC							PRINTVAR)
	#dk_buildLog(VISUAL_STUDIO					PRINTVAR)
	dk_buildLog(XCODE							PRINTVAR)
	
	dk_buildLog("#################  TARGET VARIABLES  ################")
	dk_buildLog(CMAKE_SYSTEM					PRINTVAR)
	dk_buildLog(CMAKE_SYSTEM_NAME				PRINTVAR)
	dk_buildLog(CMAKE_BINARY_DIR				PRINTVAR)
	dk_buildLog(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	PRINTVAR)
	dk_buildLog(CMAKE_LIBRARY_OUTPUT_DIRECTORY	PRINTVAR)
	dk_buildLog(CMAKE_RUNTIME_OUTPUT_DIRECTORY	PRINTVAR)
	dk_buildLog(CMAKE_GENERATOR					PRINTVAR)
	dk_buildLog(CMAKE_MAKE_PROGRAM				PRINTVAR)
	dk_buildLog(CMAKE_C_COMPILER				PRINTVAR)
	dk_buildLog(CMAKE_C_STANDARD				PRINTVAR)
	dk_buildLog(CMAKE_C_STANDARD_REQUIRED		PRINTVAR)
	dk_buildLog(CMAKE_C_EXTENSIONS				PRINTVAR)
	dk_buildLog(CMAKE_C_FLAGS					PRINTVAR)
	dk_buildLog(CMAKE_C_FLAGS_DEBUG				PRINTVAR)
	dk_buildLog(CMAKE_C_FLAGS_RELEASE			PRINTVAR)
	dk_buildLog(CMAKE_CXX_COMPILER				PRINTVAR)
	dk_buildLog(CMAKE_CXX_STANDARD				PRINTVAR)
	dk_buildLog(CMAKE_CXX_STANDARD_REQUIRED		PRINTVAR)
	dk_buildLog(CMAKE_CXX_EXTENSIONS			PRINTVAR)
	dk_buildLog(CMAKE_CXX_FLAGS					PRINTVAR)
	dk_buildLog(CMAKE_CXX_FLAGS_DEBUG			PRINTVAR)
	dk_buildLog(CMAKE_CXX_FLAGS_RELEASE			PRINTVAR)
	dk_buildLog(MULTI_CONFIG					PRINTVAR)
	dk_buildLog(SINGLE_CONFIG					PRINTVAR)
	dk_buildLog(APP_NAME						PRINTVAR)
	dk_buildLog(DK_PROJECT_DIR					PRINTVAR)
	dk_buildLog(DEBUG_DIR						PRINTVAR)
	dk_buildLog(RELEASE_DIR						PRINTVAR)
	dk_buildLog(VS_STARTUP_PROJECT				PRINTVAR)
	dk_buildLog(OS								PRINTVAR)
	dk_buildLog(DEBUG							PRINTVAR)
	dk_buildLog(RELEASE							PRINTVAR)
	dk_buildLog(BUILD							PRINTVAR)
	dk_buildLog(REBUILD							PRINTVAR)
	dk_buildLog(REBUILDALL						PRINTVAR)
	dk_buildLog(DKCEF							PRINTVAR)
	dk_buildLog(WIN								PRINTVAR)
	dk_buildLog(WIN_X86							PRINTVAR)
	dk_buildLog(WIN_X86_64						PRINTVAR)
	dk_buildLog(MAC								PRINTVAR)
	dk_buildLog(MAC_X86							PRINTVAR)
	dk_buildLog(MAC_X86_64						PRINTVAR)
	dk_buildLog(IOS								PRINTVAR)
	dk_buildLog(IOS_ARM32						PRINTVAR)
	dk_buildLog(IOS_ARM64						PRINTVAR)
	dk_buildLog(IOSSIM							PRINTVAR)
	dk_buildLog(IOSSIM_X86						PRINTVAR)
	dk_buildLog(IOSSIM_X86_64					PRINTVAR)
	dk_buildLog(LINUX							PRINTVAR)
	dk_buildLog(LINUX_X86						PRINTVAR)
	dk_buildLog(LINUX_X86_64					PRINTVAR)
	dk_buildLog(ANDROID							PRINTVAR)
	dk_buildLog(ANDROID_ARM32					PRINTVAR)
	dk_buildLog(ANDROID_ARM64					PRINTVAR)
	dk_buildLog(RASPBERRY						PRINTVAR)
	dk_buildLog(RASPBERRY_ARM32					PRINTVAR)
	dk_buildLog(RASPBERRY_ARM64					PRINTVAR)
	dk_buildLog(EMSCRIPTEN						PRINTVAR)
	dk_buildLog("")
endfunction()