#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_assets(Source_Dir)
#
#	Add a library's files to the App's assets
#
#	@Source_Dir - The path to the library or plugin who's assets we wish to include
#
function(dk_assets)
	dk_debugFunc(0 1)
	
	#if(NOT DKAPP)
	#		return()
	#endif()
	
	###### CURRENT_PLUGIN ######
	dk_assertPath(${CURRENT_PLUGIN})
	dk_basename("${${CURRENT_PLUGIN}}")
	set(Plugin_Name "${dk_basename}")
	
	###### Source_Dir ######
	if(ARGV AND	(EXISTS "${ARGV0}"))
		set(Source_Dir "${ARGV0}")
#	elseif(IsPlugin)
#		dk_getPathToPlugin("${ARGV0}")
#		set(Source_Dir "${dk_getPathToPlugin}")
	else()
		set(Source_Dir "${${CURRENT_PLUGIN}}")
	endif()	
	dk_assertPath(Source_Dir)

	if(NOT "${Source_Dir}" STREQUAL "${${CURRENT_PLUGIN}}")
		dk_notice("dk_assets(): Source_Dir:${Source_Dir} != CURRENT_PLUGIN:${${CURRENT_PLUGIN}}")
	endif()
	
	dk_info("Importing ${Source_Dir} assets...")
	
	set(ASSETS 
		PATTERN *.TEMP EXCLUDE
		PATTERN *.TMP EXCLUDE
		PATTERN *.c EXCLUDE
		PATTERN *.cmake EXCLUDE
		PATTERN *.cpp EXCLUDE
		PATTERN *.dir EXCLUDE
		PATTERN *.filters EXCLUDE
		PATTERN *.h EXCLUDE
		PATTERN *.lib EXCLUDE
		PATTERN *.manifest EXCLUDE
		PATTERN *.mm EXCLUDE
		PATTERN *.pdb EXCLUDE
		PATTERN *.plist EXCLUDE
		PATTERN *.rc EXCLUDE
		PATTERN *.sln EXCLUDE
		PATTERN *.temp EXCLUDE
		PATTERN *.tmp EXCLUDE
		PATTERN *.vcxproj EXCLUDE
		PATTERN Android_Arm32_* EXCLUDE
		PATTERN Android_Arm64_* EXCLUDE
		PATTERN Android_X86_* EXCLUDE
		PATTERN Android_X86_64_* EXCLUDE
		PATTERN CMakeFiles EXCLUDE
		PATTERN CMakeLists.txt EXCLUDE
		PATTERN Emscripten_Arm32_* EXCLUDE
		PATTERN Emscripten_Arm64_* EXCLUDE
		PATTERN Emscripten_X86_* EXCLUDE
		PATTERN Emscripten_X86_64_* EXCLUDE
		PATTERN Ios_Arm32_* EXCLUDE
		PATTERN Ios_Arm64_* EXCLUDE
		PATTERN Ios_X86_* EXCLUDE
		PATTERN Ios_X86_64_* EXCLUDE
		PATTERN Iossim_Arm32_* EXCLUDE
		PATTERN Iossim_Arm64_* EXCLUDE
		PATTERN Iossim_X86_* EXCLUDE
		PATTERN Iossim_X86_64_* EXCLUDE
		PATTERN Linux_Arm32_* EXCLUDE
		PATTERN Linux_Arm64_* EXCLUDE
		PATTERN Linux_X86_* EXCLUDE
		PATTERN Linux_X86_64_* EXCLUDE
		PATTERN Mac_Arm32_* EXCLUDE
		PATTERN Mac_Arm64_* EXCLUDE
		PATTERN Mac_X86_* EXCLUDE
		PATTERN Mac_X86_64_* EXCLUDE
		PATTERN Raspberry_Arm32_* EXCLUDE
		PATTERN Raspberry_Arm64_* EXCLUDE
		PATTERN Raspberry_X86_* EXCLUDE
		PATTERN Raspberry_X86_64_* EXCLUDE
		PATTERN Windows_Arm32_* EXCLUDE
		PATTERN Windows_Arm64_* EXCLUDE
		PATTERN Windows_X86_* EXCLUDE
		PATTERN Windows_X86_64_* EXCLUDE
		PATTERN dktest EXCLUDE
		PATTERN temp.txt EXCLUDE
	)
	
	file(COPY ${PLUGIN_Import_Path} DESTINATION ${Target_App_Dir}/assets ${ASSETS})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_assets(DK)
endfunction()