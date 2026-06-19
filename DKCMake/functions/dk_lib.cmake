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
# dk_lib(<lib_path>, <alias>:optional, <aliasB>:optional)
#
#	TODO
#
#	@lib_path			- Path to the library to include
#	@alias (optional)	- Create a variable to store the lib_path in.
#	@aliasB (optional)	- Create a variable to store the lib_path in.
#
function(dk_lib lib_path)
	dk_debugFunc(1 3)
	
	if(INSTALL_DKLIBS)
		set(${CURRENT_PLUGIN}_DKBIN "${CMAKE_INSTALL_PREFIX}/${${CURRENT_PLUGIN}_Install_Name}")
		
		if(EXISTS "${${CURRENT_PLUGIN}}")
			#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${${CURRENT_PLUGIN}_Install_Name}/${Target_Tuple})
			#file(INSTALL "${lib_path}" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}"
			file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}" FILES_MATCHING PATTERN "*.lib")
			file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}" FILES_MATCHING PATTERN "*.a")
			#file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION "${${CURRENT_PLUGIN}_DKBIN}" FILES_MATCHING PATTERN "*.exe")
			#dk_deleteEmptyDirectories("${${CURRENT_PLUGIN}_DKBIN}")
		endif()
		
		string(REPLACE "${${CURRENT_PLUGIN}}" "${${CURRENT_PLUGIN}_DKBIN}" DKBIN_lib_path "${lib_path}")
		#if(EXISTS "${DKBIN_lib_path}")
			set(lib_path "${DKBIN_lib_path}")
		#elseif(NOT EXISTS "${lib_path}")
		#	dk_error("lib_path:${lib_path} NOT FOUND")
		#endif()
	endif()	
		
	if(NOT EXISTS ${lib_path})
		dk_echo("${lyellow}dk_lib(): ${yellow}MISSING ${lib_path}${clr}")
	endif()
	
	if(lib_path IN_LIST LIBLIST)
		return() # The library is already in the list
	endif()	
	
	if(Linux OR Raspberry OR Android OR Emscripten OR MINGW)
		dk_prepend(LIBLIST ${lib_path}) # used for double checking
		dk_prepend(LIBS ${lib_path})
		dk_prepend(${CURRENT_PLUGIN}_LIBS ${lib_path})
	else()
		dk_append(LIBLIST ${lib_path}) # used for double checking
		dk_append(LIBS ${lib_path})
		dk_append(${CURRENT_PLUGIN}_LIBS ${lib_path})
	endif()
	dk_set(LIBLIST "${LIBLIST}")
	dk_set(LIBS "${LIBS}")
	set(ENV{LIBS} "${LIBS}")  # Export an enviromnent variable so the App's CMakeLists.txt can import it
	dk_set(${CURRENT_PLUGIN}_LIBS "${${CURRENT_PLUGIN}_LIBS}")
	
	if(ARGV1)
		dk_set(${ARGV1} ${lib_path})
	endif()
	if(ARGV2)
		dk_set(${ARGV2} ${lib_path})
	endif()

endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_lib(zlib ${zlib_Debug_Dir}/zd.lib)
endfunction()