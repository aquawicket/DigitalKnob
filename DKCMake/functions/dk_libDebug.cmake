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
# dk_libDebug(<lib_path>, <alias>:optional)
#
#	TODO
#
#	@lib_path	- TODO
#	@alias (optional)	- Create a variable to store the lib_path in.
#
function(dk_libDebug lib_path)
	dk_debugFunc()
	
	if(NOT Debug)
		return()
	endif()

	if(NOT EXISTS ${lib_path})
		dk_echo("${lyellow}MISSING:${yellow} ${lib_path}${clr}")
	endif()
		
	if(lib_path IN_LIST LIBLIST)
		return() # The library is already in the list
	endif()
	
	if(Linux OR Raspberry OR Android OR Emscripten OR MINGW) # FIXME: can this be covered with MULTI_CONFIG and SINGLE_CONFIG ?
		dk_prepend(LIBLIST ${lib_path})
		dk_prepend(DEBUG_LIBS debug ${lib_path})
		dk_prepend(${CURRENT_PLUGIN}_LIBS ${lib_path})
	else()
		dk_append(LIBLIST ${lib_path})
		dk_append(DEBUG_LIBS debug ${lib_path})
		dk_append(${CURRENT_PLUGIN}_LIBS ${lib_path})
	endif()
	dk_set(LIBLIST "${LIBLIST}")
	dk_set(DEBUG_LIBS "${DEBUG_LIBS}")
	dk_set(${CURRENT_PLUGIN}_LIBS "${${CURRENT_PLUGIN}_LIBS}")

	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			#dk_assertVar($ENV{CURRENT_PLUGIN}_Import_Name)
			#set(LIB_NAME ${$ENV{CURRENT_PLUGIN}_Import_Name}) # get the import folder name of the plugin
			#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${Target_Tuple}/Debug)
			file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${Target_Tuple}/Debug)
		endif()
	endif()
	
	if(ARGV1)
		dk_set(${ARGV1} ${lib_path}) # add the lib_path to the supplied variable
	endif()
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_libDebug(todo) #TODO
endfunction()