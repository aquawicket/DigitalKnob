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
dk_load(DKDEBUGFUNC)
dk_load(DKASSERT)
dk_load(DKERROR)
dk_load(DKWARN)
dk_load(DKINFO)
dk_load(DKDEBUG)
dk_load(DKVERBOSE)
dk_load(DKTRACE)
