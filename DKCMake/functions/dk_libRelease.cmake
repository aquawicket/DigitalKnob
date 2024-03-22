include_guard()

###############################################################################
# dk_libRelease(lib_path)
#
#	TODO
#
#	@lib_path		- TODO
#	@variable (optional)	- Create a variable to store the lib_path in.
#
function(dk_libRelease lib_path)
	DKDEBUGFUNC(${ARGV})
	if(NOT RELEASE)
		return()
	endif()
	
	dk_set(LIBLIST ${LIBLIST} ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_info("MISSING: ${lib_path}")
		dk_set(QUEUE_BUILD ON)
	endif()
	
	string(FIND "${RELEASE_LIBS}" "${lib_path}" index)
	if(${index} GREATER -1)
	#dk_includes("${RELEASE_LIBS}" "${lib_path}" result)
	#if(${result})
		return() # The library is already in the list
	endif()	
	
	if(LINUX OR RASPBERRY OR ANDROID OR EMSCRIPTEN OR MINGW)
		dk_set(RELEASE_LIBS optimized ${lib_path} ${RELEASE_LIBS})  # Add to beginning of list
	else()
		dk_set(RELEASE_LIBS ${RELEASE_LIBS} optimized ${lib_path})  # Add to end of list
	endif()
	
	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
			file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${OS}/Release)
		endif()
	endif()
	
	if(ARGV1)
		dk_set(${ARGV1} ${lib_path}) # add the lib_path to the supplied variable
	endif()
	
endfunction()
dk_createOsMacros("dk_libRelease" "NO_DEBUG_RELEASE_TAGS")