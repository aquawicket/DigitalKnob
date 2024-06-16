include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_dll(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_dll plugin_name)
	dk_debugFunc(${ARGV})
	
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_error("${plugin_name} plugin not found")
	endif()
	dk_include(${plugin_path})
	# Create CmakeLists.txt file
	dk_remove(${plugin_path}/CMakeLists.txt NOERROR)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKFunctions.cmake)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKVariables.cmake)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "if(IOS)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		set(PLATFORM OS64)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		include(${DKCMAKE_DIR}/ios.toolchain.cmake)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		add_definitions(-DIOS)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "endif()\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "if(IOSSIM)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		set(PLATFORM SIMULATOR64)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		include(${DKCMAKE_DIR}/ios.toolchain.cmake)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		add_definitions(-DIOS)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "endif()\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")
	foreach(each_include ${DKINCLUDES_LIST})
		dk_fileAppend(${plugin_path}/CMakeLists.txt "include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		dk_fileAppend(${plugin_path}/CMakeLists.txt "add_definitions(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		dk_fileAppend(${plugin_path}/CMakeLists.txt "link_directories(${each_linkdir})\n")
	endforeach()
	dk_fileAppend(${plugin_path}/CMakeLists.txt "file(GLOB ${plugin_name}_SRC \n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		${plugin_path}/*.h\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.c\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.cpp\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.rc\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.manifest\n")
	if(IOS OR IOSSIM)
		dk_fileAppend(${plugin_path}/CMakeLists.txt "		${plugin_path}/*.mm\n")
	endif()
	dk_fileAppend(${plugin_path}/CMakeLists.txt ")\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "add_library(${plugin_name} SHARED \${${plugin_name}_SRC})\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "add_definitions(-D_WIN32_WINNT=0x0600)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "set_target_properties(${plugin_name} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "target_compile_options(${plugin_name} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
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
		#dk_fileAppend(${plugin_path}/CMakeLists.txt "target_link_libraries(${plugin_name} debug ${DKPLUGINS_DIR}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS_DIR}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
		dk_fileAppend(${plugin_path}/CMakeLists.txt "target_link_libraries(${plugin_name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
	endif()
	dk_fileAppend(${plugin_path}/CMakeLists.txt "if(WIN_HOST)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "		set_target_properties(${plugin_name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	dk_fileAppend(${plugin_path}/CMakeLists.txt "endif()\n")
	endif()
	dk_add_to_plugin_list(${plugin_name})
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)