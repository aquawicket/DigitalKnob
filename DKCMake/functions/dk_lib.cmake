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
# dk_lib(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
#
function(dk_lib lib_path)
	dk_debugFunc()
	
	foreach(item ${ARGV})
		dk_includes(LIBS "${item}")
		if(dk_includes)
			continue() # item is already in the list
		endif()
		dk_append(LIBS "${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				#dk_assertVar($ENV{CURRENT_PLUGIN}_IMPORT_NAME)
				#set(LIB_NAME ${$ENV{CURRENT_PLUGIN}_IMPORT_NAME}) # get the import folder name of the plugin
				#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${Target_Tuple})
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib//${Target_Tuple})
			else()
				dk_warning("DKINSTALL: Could not locate ${lib_path}")
			endif()
		endif()	
	endforeach()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()