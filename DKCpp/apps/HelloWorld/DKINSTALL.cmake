#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


include("$ENV{DKCMAKE_FUNCTIONS_DIR_}dk_call.cmake")
dk_call(dk_DKBRANCH_DIR)
dk_call(dk_Target_Tuple)
dk_call(dk_set Target_App_Dir "${CMAKE_CURRENT_LIST_DIR}")

if(EXISTS "${Target_App_Dir}/depends.cmake")
	include("${Target_App_Dir}/depends.cmake")
endif()

############ Plugins.h file ############
if(PLUGINS_FILE)
	dk_set(PLUGINS_FILE		${PLUGINS_FILE})
	dk_replaceAll("${PLUGINS_FILE}" "#include 	\"DKWindow.h\""  ""  	PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}"  "\\n"  	"\n" 			 		PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}"  ";"  		""  					PLUGINS_FILE)
endif()
dk_fileWrite("${Target_App_Dir}/DKPlugins.h" "${PLUGINS_FILE}")

dk_set(DKCPP_PLUGINS_DIR 	"${DKCPP_PLUGINS_DIR}")
file(GLOB HEADER_FILES RELATIVE ${DKCPP_PLUGINS_DIR} ${CMAKE_CURRENT_LIST_DIR}/*.h)
foreach(header ${HEADER_FILES})
	if(NOT PLUGINS_FILE MATCHES "${header}")
		dk_set(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
	endif()
endforeach()
########################################

dk_call(dk_copy ${DKCPP_PLUGINS_DIR}/_DKIMPORT/_CMakeLists.txt_ ${Target_App_Dir}/CMakeLists.txt)

dk_basename("${Target_App_Dir}")
dk_envList(PLUGIN PUSH "${dk_basename}")
dk_set(${CURRENT_PLUGIN}	"${Target_App_Dir}")

dk_define(DKAPP)
dk_call(dk_configure "${Target_App_Dir}")
dk_build("${Target_App_Dir}")