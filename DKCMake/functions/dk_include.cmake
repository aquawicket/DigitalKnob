include_guard()

###############################################################################
# dk_include(path) variable
#
#	Add a directory to the compiler include paths
#
#	@path					- The path to add to the compiler include paths
#   @variable (optional)	- Create a variable to store the path in.
#
function(dk_include path)
	DKDEBUGFUNC(${ARGV})
	
	if(CMAKE_SCRIPT_MODE_FILE)
		dk_warn("${CMAKE_CURRENT_FUNCTION}() cannot run in script mode.")
		return()
	endif()
	
	list(FIND DKINCLUDES_LIST "${path}" index)
	if(${index} GREATER -1)
		dk_return()	# path is already in the list
	endif()
		
	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL DIRECTORY ${path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${LIB_NAME} FILES_MATCHING PATTERN "*.h")
		dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include/${LIB_NAME})
	endif()
		
	dk_set(DKINCLUDES_LIST ${DKINCLUDES_LIST} ${path})

	include_directories(${path})
		
	if(ARGV1)
		dk_set(${ARGV1} ${path}) # add the path to the supplied variable
	endif()

endfunction()
dk_createOsMacros("dk_include")