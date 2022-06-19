# Get the /digitalknob path 
function(dk_getDigitalknobPath result)
	get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
	get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
	while(NOT FOLDER_NAME STREQUAL "digitalknob")
		get_filename_component(DIGITALKNOB ${DIGITALKNOB} DIRECTORY)
		get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
		if(NOT FOLDER_NAME)
			message(FATAL_ERROR "Could not locate digitalknob root path")
		endif()
	endwhile()
	set(${result} ${DIGITALKNOB} PARENT_SCOPE)
endfunction()
dk_getDigitalknobPath(DIGITALKNOB)
set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake)


# Set the system host variables
if(CMAKE_HOST_WIN32)
	set(WIN_HOST 	TRUE 	CACHE INTERNAL "")
endif()
if(CMAKE_HOST_APPLE)
	set(UNIX_HOST 	TRUE 	CACHE INTERNAL "")
	set(MAC_HOST 	TRUE 	CACHE INTERNAL "")
endif()
if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(UNIX_HOST 	TRUE 	CACHE INTERNAL "")
	set(LINUX_HOST 	TRUE 	CACHE INTERNAL "")
endif()


# include the DKCall function
include(${DKCMAKE}/dk_call.cmake)


# include other dk funtions
dk_load(dk_debugFunc)
dk_load(dk_assert)
dk_load(dk_error)
dk_load(dk_warn)
dk_load(dk_info)
dk_load(dk_debug)
dk_load(dk_verbose)
dk_load(dk_trace)
