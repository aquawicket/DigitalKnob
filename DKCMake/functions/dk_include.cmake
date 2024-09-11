include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_include(path) variable
#
#	Add a directory to the compiler include paths
#
#	@path					- The path to add to the compiler include paths
#   @variable (optional)	- Create a variable to store the path in.
#
function(dk_include path)
	dk_debugFunc("\${ARGV}")
	
	list(FIND DKINCLUDES_LIST "${path}" index)
	if(${index} GREATER -1)
		dk_return()	# path is already in the list
	endif()
		
	if(INSTALL_DKLIBS)
		dk_basename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL DIRECTORY ${path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${LIB_NAME} FILES_MATCHING PATTERN "*.h")
		dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include/${LIB_NAME})
	endif()
		
	dk_append(DKINCLUDES_LIST ${path})
	if(CMAKE_SCRIPT_MODE_FILE)
		dk_warning("${include_directories}() cannot run in script mode.")
	else()
		include_directories(${path})
	endif()
		
	if(ARGV1)
		dk_set(${ARGV1} ${path}) # add the path to the supplied variable
	endif()

endfunction()
dk_createOsMacros("dk_include")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()