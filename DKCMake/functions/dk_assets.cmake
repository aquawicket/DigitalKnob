#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_assets(plugin)
#
#	Add a library's files to the App's assets
#
#	@plugin		- TODO
#
function(dk_assets plugin)
	dk_debugFunc(1)
	
	if(NOT DKAPP)
		return()
	endif()	
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		dk_fatal("${plugin} plugin not found")
	endif()
	dk_info("Importing ${plugin} assets...")
	
	set(ASSETS 
		PATTERN *.h EXCLUDE
		PATTERN *.c EXCLUDE
		PATTERN *.cmake EXCLUDE
		PATTERN *.cpp EXCLUDE
		PATTERN *.dir EXCLUDE
		PATTERN *.filters EXCLUDE
		PATTERN *.lib EXCLUDE
		PATTERN *.manifest EXCLUDE
		PATTERN *.mm EXCLUDE
		PATTERN *.pdb EXCLUDE
		PATTERN *.plist EXCLUDE
		PATTERN *.rc EXCLUDE
		PATTERN *.sln EXCLUDE
		PATTERN *.tmp EXCLUDE
		PATTERN *.TMP EXCLUDE
		PATTERN *.temp EXCLUDE
		PATTERN *.TEMP EXCLUDE
		PATTERN *.vcxproj EXCLUDE
		PATTERN CMakeFiles EXCLUDE
		PATTERN CMakeLists.txt EXCLUDE
		PATTERN temp.txt EXCLUDE
		PATTERN win_x86 EXCLUDE
		PATTERN win_x86_64 EXCLUDE
		PATTERN mac_x86 EXCLUDE
		PATTERN mac_x86_64 EXCLUDE
		PATTERN ios_arm32 EXCLUDE
		PATTERN ios_arm64 EXCLUDE
		PATTERN Iossim_X86 EXCLUDE
		PATTERN iossim_x86_64 EXCLUDE
		PATTERN linux_x86 EXCLUDE
		PATTERN linux_x86_64 EXCLUDE
		PATTERN Android_Arm32 EXCLUDE
		PATTERN android_arm64 EXCLUDE
		PATTERN android_x86 EXCLUDE
		PATTERN android_x86_64 EXCLUDE
		PATTERN raspberry_arm32 EXCLUDE
		PATTERN raspberry_arm64 EXCLUDE
		PATTERN emscripten EXCLUDE
		PATTERN dktest EXCLUDE)
	
	file(COPY ${plugin_path} DESTINATION ${DK_Project_Dir}/assets ${ASSETS})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_assets(DK)
endfunction()