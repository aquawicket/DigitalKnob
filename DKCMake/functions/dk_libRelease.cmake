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
# dk_libRelease(<lib_path>, <alias>:optional, <aliasB>:optional)
#
#	TODO
#
#	@lib_path			- Path to the library to include
#	@alias (optional)	- Create a variable to store the lib_path in.
#	@aliasB (optional)	- Create a variable to store the lib_path in.
#
function(dk_libRelease lib_path)
	dk_debugFunc(1 3)
	
	
	if(NOT Release)
		return()
	endif()
	
	if(NOT EXISTS ${lib_path})
		dk_echo("${lyellow}MISSING:${yellow} ${lib_path}${clr}")
	endif()
	
	if(lib_path IN_LIST LIBLIST)
		return() # The library is already in the list
	endif()	
	
	if(Linux OR Raspberry OR Android OR Emscripten OR MINGW)
		dk_prepend(LIBLIST ${lib_path}) 
		dk_prepend(RELEASE_LIBS optimized ${lib_path})
		dk_prepend(${CURRENT_PLUGIN}_LIBS ${lib_path})
	else()
		dk_append(LIBLIST ${lib_path})
		dk_append(RELEASE_LIBS optimized ${lib_path})
		dk_append(${CURRENT_PLUGIN}_LIBS ${lib_path})
	endif()
	dk_set(LIBLIST "${LIBLIST}")
	dk_set(RELEASE_LIBS "${RELEASE_LIBS}")
	dk_set(${CURRENT_PLUGIN}_LIBS "${${CURRENT_PLUGIN}_LIBS}")
	
	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${${CURRENT_PLUGIN}_Import_Name}/${Target_Tuple}/Release)
			file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${Target_Tuple}/Release)
		else()
			dk_warning("DKINSTALL: Could not locate ${lib_path}")
		endif()
	endif()
	
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
	
	dk_libRelease(todo) # TODO
endfunction()