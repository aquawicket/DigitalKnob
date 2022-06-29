include_guard()

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


# Set the DIGITALKNOB and DKCMAKE environment variables 
get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
string(FIND "${path}" "digitalknob" pos)
string(SUBSTRING ${path} 0 ${pos} path)
set(DIGITALKNOB ${path}digitalknob CACHE INTERNAL "")
set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake CACHE INTERNAL "")
set(ENV{DIGITALKNOB} ${DIGITALKNOB})
set(ENV{DKCMAKE} ${DKCMAKE})
if(WIN_HOST)
	execute_process(COMMAND cmd /c setx DIGITALKNOB ${DIGITALKNOB})
	execute_process(COMMAND cmd /c setx DKCMAKE ${DKCMAKE})
endif()


# include dk funtions
include(${DKCMAKE}/dk_call.cmake)
dk_load(dk_debugFunc)
dk_load(dk_assert)
dk_load(dk_error)
dk_load(dk_warn)
dk_load(dk_info)
dk_load(dk_debug)
dk_load(dk_verbose)
dk_load(dk_trace)
dk_load(dk_return)

dk_load(DKFunctions)
dk_load(DKFileSystem)
dk_load(DKVariables)
dk_load(DKDisabled)


dk_load(dk_import2)
