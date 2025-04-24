#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
		if(LIBS MATCHES "${item}")
=======
		dk_includes(LIBS "${item}")
		if(dk_includes)
>>>>>>> Development
			continue() # item is already in the list
		endif()
		dk_append(LIBS "${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
<<<<<<< HEAD
				dk_basename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${triple})
=======
				#dk_assertVar($ENV{CURRENT_PLUGIN}_IMPORT_NAME)
				#set(LIB_NAME ${$ENV{CURRENT_PLUGIN}_IMPORT_NAME}) # get the import folder name of the plugin
				#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${target_triple})
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib//${target_triple})
>>>>>>> Development
			else()
				dk_warning("DKINSTALL: Could not locate ${lib_path}")
			endif()
		endif()	
	endforeach()
endfunction()
<<<<<<< HEAD
dk_createOsMacros("dk_lib" "NO_DEBUG_RELEASE_TAGS")
=======

>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()