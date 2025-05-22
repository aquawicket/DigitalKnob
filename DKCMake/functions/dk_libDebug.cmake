#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
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
	
	dk_append(LIBLIST ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_echo("${lyellow}MISSING:${yellow} ${lib_path}${clr}")
		dk_set(QUEUE_BUILD ON) 
	endif()
	
	if(lib_path IN_LIST DEBUG_LIBS)
		return() # The library is already in the list
	endif()
	
	if(Linux OR Raspberry OR Android OR Emscripten OR MINGW) # FIXME: can this be covered with MULTI_CONFIG and SINGLE_CONFIG ?
		dk_prepend(DEBUG_LIBS debug ${lib_path}) # Add to beginning of list
	else()
		dk_append(DEBUG_LIBS debug ${lib_path}) # Add to end of list
	endif()

	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			#dk_assertVar($ENV{CURRENT_PLUGIN}_IMPORT_NAME)
			#set(LIB_NAME ${$ENV{CURRENT_PLUGIN}_IMPORT_NAME}) # get the import folder name of the plugin
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