#!/usr/bin/cmake -P
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
				#file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${target_triple})
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib//${target_triple})
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