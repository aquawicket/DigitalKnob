include_guard()

cmake_policy(SET CMP0007 NEW)
cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0054 NEW)
cmake_policy(SET CMP0057 NEW)
set(ENABLE_DKTEST 1)

set(CMAKE_MESSAGE_LOG_LEVEL "TRACE")
if(CMAKE_SCRIPT_MODE_FILE)
	message("")
	message("########################################################")
	message("################# CMAKE SCRIPT MODE ####################")
	message("########################################################")
	message("")
endif()

###### set DKSCRIPT_ variables ######
set(DKSCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}")
get_filename_component(DKSCRIPT_DIR ${DKSCRIPT_PATH} DIRECTORY CACHE INTERNAL "")
get_filename_component(DKSCRIPT_NAME ${DKSCRIPT_PATH} NAME CACHE INTERNAL "")

###### get DKCMAKE_DIR ######
get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY CACHE INTERNAL "")
set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions CACHE INTERNAL "")
#if(NOT DKCMAKE_DIR)
#	message("CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
#	dk_getDirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
#	get_filename_component(DKCMAKE ${CMAKE_CURRENT_LIST_DIR} NAME)
#	if(${DKCMAKE} STREQUAL "DKCMake")
#		set(DKCMAKE_DIR ${DKCMAKE_DIR} CACHE INTERNAL "" FORCE)
#	endif()
#	message("DKCMAKE_DIR = ${DKCMAKE_DIR}")
#endif()

###### load default function ####
include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
include(${DKCMAKE_FUNCTIONS_DIR}/dk_eval.cmake)
include(${DKCMAKE_FUNCTIONS_DIR}/dk_debugFunc.cmake)
dk_load(dk_eval)
dk_load(dk_escapeSequences)
dk_escapeSequences()
dk_load(${DKSCRIPT_PATH})


###### DKTEST MODE ######
if("${ENABLE_DKTEST}" EQUAL "1")
if("${DKSCRIPT_DIR}" STREQUAL "${DKCMAKE_FUNCTIONS_DIR}")
	message("\n###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######\n")
			
	DKTEST()
	
	message("\n########################## END TEST ################################\n")
	dk_pause()
endif()
endif()



