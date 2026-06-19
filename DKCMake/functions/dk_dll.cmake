#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_dll(Plugin_name)
#
#	TODO
#
#	@Plugin_name	- TODO
#
function(dk_dll Plugin_name)
	dk_debugFunc()
	
	dk_getImportPath(${Plugin_name} PLUGIN_Import_Path)
	if(NOT EXISTS "${PLUGIN_Import_Path}")
		dk_fatal("${Plugin_name} Plugin NOT FOUND")
	endif()
	dk_include(${PLUGIN_Import_Path})
	
	###### Create CmakeLists.txt file ######
	dk_delete(${PLUGIN_Import_Path}/CMakeLists.txt NO_HALT)
	if(NOT EXISTS "${PLUGIN_Import_Path}/CMakeLists.txt")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt 
			"### ${Plugin_name} ###"
			"cmake_minimum_required(VERSION 3.10)"
			#"cmake_policy(SET CMP0054 NEW)"
			"include(${DKCMAKE_DIR}/DKFunctions.cmake)"
			"include(${DKCMAKE_DIR}/DKVariables.cmake)"
			"if(Ios)"
			"		set(PLATFORM OS64)"
			"		include(${DKCMAKE_DIR}/ios.toolchain.cmake)"
			"		add_definitions(-DIOS)"
			"endif()"
			"if(Iossim)"
			"		set(PLATFORM SIMULATOR64)"
			"		include(${DKCMAKE_DIR}/ios.toolchain.cmake)"
			"		add_definitions(-DIOS)"
			"endif()"
			"project(${Plugin_name})"
			"include_directories(${DKINCLUDES_LIST})"
			"add_definitions(${DKDEFINES_LIST})"
			"link_directories(${DKLINKDIRS_LIST})"
			"file(GLOB ${Plugin_name}_SRC "
			"		${PLUGIN_Import_Path}/*.h"
			"    	${PLUGIN_Import_Path}/*.c"
			"    	${PLUGIN_Import_Path}/*.cpp"
			"    	${PLUGIN_Import_Path}/*.rc"
			"    	${PLUGIN_Import_Path}/*.manifest"
			"")
		if(Ios OR Iossim)
			dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "		${PLUGIN_Import_Path}/*.mm" "")
		endif()
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt ")\n")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "add_library(${Plugin_name} SHARED \${${Plugin_name}_SRC})\n")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "add_definitions(-D_WIN32_WINNT=0x0600)\n")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "set_target_properties(${Plugin_name} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "target_compile_options(${Plugin_name} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
		if(DEBUG_LIBS)
			dk_replaceAll(${DEBUG_LIBS} "debug" " debug " DLL_DEBUG_LIBS)
		endif()
		if(RELEASE_LIBS)
			dk_replaceAll(${RELEASE_LIBS} "optimized" " optimized " DLL_RELEASE_LIBS)
		endif()
		if(LIBS)
			dk_replaceAll(${LIBS} ".lib" ".lib " DLL_LIBS)
		endif()
		if(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
			#dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "target_link_libraries(${Plugin_name} debug ${DKCPP_PLUGINS_DIR}/DK/${Target_Tuple}/${Debug_Dir}/DK.lib optimized ${DKCPP_PLUGINS_DIR}/DK/${Target_Tuple}/${Release_Dir}/DK.lib) \n")
			dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "target_link_libraries(${Plugin_name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
		endif()
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "if(Windows_Host)\n")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "		set_target_properties(${Plugin_name} PROPERTIES LINKER_LANGUAGE CPP)\n")
		dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "endif()\n")
	endif()
	dk_addToPluginList(${Plugin_name})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()