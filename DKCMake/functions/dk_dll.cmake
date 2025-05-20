#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_dll(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_dll plugin_name)
	dk_debugFunc()
	
	dk_getPathToPlugin(${plugin_name} Plugin_Path)
	if(NOT EXISTS "${Plugin_Path}")
		dk_fatal("${plugin_name} plugin not found")
	endif()
	dk_include(${Plugin_Path})
	
	###### Create CmakeLists.txt file ######
	dk_delete(${Plugin_Path}/CMakeLists.txt NO_HALT)
	if(NOT EXISTS "${Plugin_Path}/CMakeLists.txt")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "### ${plugin_name} ###\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
		#dk_fileAppend(${Plugin_Path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "include($ENV{DKCMAKE_DIR}/DKFunctions.cmake)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "include($ENV{DKCMAKE_DIR}/DKVariables.cmake)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "if(IOS)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		set(PLATFORM OS64)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		include($ENV{DKCMAKE_DIR}/ios.toolchain.cmake)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		add_definitions(-DIOS)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "endif()\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "if(Iossim)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		set(PLATFORM SIMULATOR64)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		include($ENV{DKCMAKE_DIR}/ios.toolchain.cmake)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		add_definitions(-DIOS)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "endif()\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "project(${plugin_name})\n")
		foreach(each_include ${DKINCLUDES_LIST})
			dk_fileAppend(${Plugin_Path}/CMakeLists.txt "include_directories(${each_include})\n")
		endforeach()
		foreach(each_define ${DKDEFINES_LIST})
			dk_fileAppend(${Plugin_Path}/CMakeLists.txt "add_definitions(-D${each_define})\n")
		endforeach()
		foreach(each_linkdir ${DKLINKDIRS_LIST})
			dk_fileAppend(${Plugin_Path}/CMakeLists.txt "link_directories(${each_linkdir})\n")
		endforeach()
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "file(GLOB ${plugin_name}_SRC \n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		${Plugin_Path}/*.h\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "    	${Plugin_Path}/*.c\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "    	${Plugin_Path}/*.cpp\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "    	${Plugin_Path}/*.rc\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "    	${Plugin_Path}/*.manifest\n")
		if(IOS OR Iossim)
			dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		${Plugin_Path}/*.mm\n")
		endif()
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt ")\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "add_library(${plugin_name} SHARED \${${plugin_name}_SRC})\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "add_definitions(-D_WIN32_WINNT=0x0600)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "set_target_properties(${plugin_name} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "target_compile_options(${plugin_name} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
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
			#dk_fileAppend(${Plugin_Path}/CMakeLists.txt "target_link_libraries(${plugin_name} debug ${DKCPP_PLUGINS_DIR}/DK/${Target_Tuple}/${Debug_Dir}/DK.lib optimized ${DKCPP_PLUGINS_DIR}/DK/${Target_Tuple}/${Release_Dir}/DK.lib) \n")
			dk_fileAppend(${Plugin_Path}/CMakeLists.txt "target_link_libraries(${plugin_name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
		endif()
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "if(Windows_Host)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "		set_target_properties(${plugin_name} PROPERTIES LINKER_LANGUAGE CPP)\n")
		dk_fileAppend(${Plugin_Path}/CMakeLists.txt "endif()\n")
	endif()
	dk_addToPluginList(${plugin_name})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()