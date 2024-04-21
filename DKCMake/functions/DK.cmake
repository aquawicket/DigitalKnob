include_guard()

###### Global Script Variables ######
set(ENABLE_dk_debug			1		CACHE INTERNAL "")	# enable dk_debug() functions
set(ENABLE_dk_verbose		1		CACHE INTERNAL "")	# enable dk_verbose() functions



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
#if(NOT DKCMAKE_DIR)
#	message("CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
#	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
#	get_filename_component(DKCMAKE ${CMAKE_CURRENT_LIST_DIR} NAME)
#	if(${DKCMAKE} STREQUAL "DKCMake")
#		set(DKCMAKE_DIR ${DKCMAKE_DIR} CACHE INTERNAL "" FORCE)
#	endif()
#	message("DKCMAKE_DIR = ${DKCMAKE_DIR}")
#endif()

###### load default function ####
include(${DKCMAKE_DIR}/functions/dk_load.cmake)
include(${DKCMAKE_DIR}/functions/dk_eval.cmake)
dk_load(${SCRIPT_PATH})
dk_load(dk_color)