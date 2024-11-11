#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_lib(lib_path) NO_HALT
#
#	TODO
#
#	@lib_path	- TODO
#
function(dk_lib lib_path)
	dk_debugFunc()
	
	dk_getOption(NO_HALT ${ARGV} REMOVE)
	
	foreach(item ${ARGV})
		if(LIBS MATCHES "${item}")
			continue() # item is already in the list
		endif()
		dk_append(LIBS "${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				dk_basename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${triple})
			else()
				dk_error("DKINSTALL: Could not locate ${lib_path}" ${NO_HALT})
			endif()
		endif()	
	endforeach()
endfunction()
dk_createOsMacros("dk_lib" "NO_DEBUG_RELEASE_TAGS")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()