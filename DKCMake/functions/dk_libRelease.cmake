include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_libRelease(lib_path)
#
#	TODO
#
#	@lib_path		- TODO
#	@variable (optional)	- Create a variable to store the lib_path in.
#
function(dk_libRelease lib_path)
	dk_debugFunc("\${ARGV}")
	
	if(NOT RELEASE)
		return()
	endif()
	
	dk_append(LIBLIST ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_echo("${lyellow}MISSING:${yellow} ${lib_path}${clr}")
		dk_set(QUEUE_BUILD ON)
	endif()
	
	if(lib_path IN_LIST RELEASE_LIBS)
		return() # The library is already in the list
	endif()	
	
	if(LINUX OR RASPBERRY OR ANDROID OR EMSCRIPTEN OR MINGW)
		dk_prepend(RELEASE_LIBS optimized ${lib_path})  # Add to beginning of list
	else()
		dk_append(RELEASE_LIBS optimized ${lib_path})  # Add to end of list
	endif()
	
	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			dk_basename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
			file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${triple}/Release)
		endif()
	endif()
	
	if(ARGV1)
		dk_set(${ARGV1} ${lib_path}) # add the lib_path to the supplied variable
	endif()
	
endfunction()
dk_createOsMacros("dk_libRelease" "NO_DEBUG_RELEASE_TAGS")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()