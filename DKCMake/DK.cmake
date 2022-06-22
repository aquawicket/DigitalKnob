include_guard()

# Get the /digitalknob path 
#function(dk_getDigitalknobPath result)
#	get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
#	get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
#	while(NOT FOLDER_NAME STREQUAL "digitalknob")
#		get_filename_component(DIGITALKNOB ${DIGITALKNOB} DIRECTORY)
#		get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
#		if(NOT FOLDER_NAME)
#			message(FATAL_ERROR "Could not locate digitalknob root path")
#		endif()
#	endwhile()
#	set(${result} ${DIGITALKNOB} PARENT_SCOPE)
#endfunction()
#dk_getDigitalknobPath(DIGITALKNOB)
#set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake)


function(dk_setDigitalknobPath)
	get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
	string(FIND "${path}" "digitalknob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(ENV{DIGITALKNOB} ${path}digitalknob)
	set(DIGITALKNOB $ENV{DIGITALKNOB} CACHE INTERNAL "")
endfunction()
dk_setDigitalknobPath()
#set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake CACHE INTERNAL "")

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
include(${DIGITALKNOB}/DK/DKCMake/dk_call.cmake)


# include other dk funtions
dk_load(dk_debugFunc)
dk_load(dk_assert)
dk_load(dk_error)
dk_load(dk_warn)
dk_load(dk_info)
dk_load(dk_debug)
dk_load(dk_verbose)
dk_load(dk_trace)
