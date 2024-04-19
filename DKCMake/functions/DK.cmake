include_guard()

###### Global Script Variables ######
set(DKVERBOSE_ENABLED 1	CACHE INTERNAL "") 	# export LOG_VERBOSE=1
set(DKDEBUG_ENABLED	  1 CACHE INTERNAL "") 	# export LOG_DEBUG=1
# export TRACE_ON_WARNINGS=0
set(HALT_ON_WARNINGS  0 CACHE INTERNAL "")  # export HALT_ON_WARNINGS=1
set(HALT_ON_ERRORS    1	CACHE INTERNAL "")  # export CONTINUE_ON_ERRORS=0


if(CMAKE_SCRIPT_MODE_FILE)
	message("")
	message("########################################################")
	message("################# CMAKE SCRIPT MODE ####################")
	message("########################################################")
	message("")
endif()

###### set SCRIPT_ variables ######
set(SCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}")

###### get DKCMAKE_DIR ######
get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY CACHE INTERNAL "")

###### load default function ####
include(${DKCMAKE_DIR}/functions/dk_load.cmake)
dk_load(${SCRIPT_PATH})
dk_load(dk_debugfunc)
dk_load(dk_color)