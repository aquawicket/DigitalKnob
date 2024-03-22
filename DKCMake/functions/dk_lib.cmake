include_guard()

###############################################################################
# dk_lib(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
#
function(dk_lib lib_path)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${ARGV})
#		dk_set(LIBLIST "${LIBLIST} ${lib_path}") ## used for double checking
		dk_includes("${LIBS}" "${item}" result)
		if(${result})
			continue() # item is already in the list
		endif()
		dk_set(LIBS "${LIBS};${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${OS})
			else()
				dk_warn("DKINSTALL: Could not locate ${lib_path}")
			endif()
		endif()
		
	endforeach()
endfunction()
dk_createOsMacros("dk_lib" "NO_DEBUG_RELEASE_TAGS")