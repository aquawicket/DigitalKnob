include_guard()

###############################################################################
# dk_libDebug(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
#	@variable (optional)	- Create a variable to store the lib_path in.
#
function(dk_libDebug lib_path)
	DKDEBUGFUNC(${ARGV})
	if(NOT DEBUG)
		return()
	endif()	
	
	dk_set(LIBLIST ${LIBLIST} ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_info("MISSING: ${lib_path}")
		dk_set(QUEUE_BUILD ON) 
	endif()
	
	string(FIND "${DEBUG_LIBS}" "${lib_path}" index)
	if(${index} GREATER -1)
	#dk_includes("${DEBUG_LIBS}" "${lib_path}" result)
	#if(${result})
		return() # The library is already in the list
	endif()
	
	if(LINUX OR RASPBERRY OR ANDROID OR EMSCRIPTEN OR MINGW) # FIXME: can this be covered with MULTI_CONFIG and SINGLE_CONFIG ?
		dk_set(DEBUG_LIBS debug ${lib_path} ${DEBUG_LIBS})  # Add to beginning of list
	else()
		dk_set(DEBUG_LIBS ${DEBUG_LIBS} debug ${lib_path})  # Add to end of list
	endif()

	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
			file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${OS}/Debug)
		endif()
	endif()
	
	if(ARGV1)
		dk_set(${ARGV1} ${lib_path}) # add the lib_path to the supplied variable
	endif()
	
endfunction()
dk_createOsMacros("dk_libDebug" "NO_DEBUG_RELEASE_TAGS")