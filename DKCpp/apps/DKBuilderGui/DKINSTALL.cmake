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


dk_Target_Tuple()

### DEPEND ###
#none


### TODO: Add Plugins.h file generation ###
if(DKINCLUDES_LIST)
	dk_set(DKINCLUDES_LIST ${DKINCLUDES_LIST})
endif()
if(DKDEFINES_LIST)
	dk_set(DKDEFINES_LIST ${DKDEFINES_LIST})
endif()
if(DKLINKDIRS_LIST)
	dk_set(DKLINKDIRS_LIST ${DKLINKDIRS_LIST})
endif()
if(LIBS)
	dk_set(LIBS ${LIBS})
endif()
if(DEBUG_LIBS)
	dk_set(DEBUG_LIBS ${DEBUG_LIBS})
endif()
if(RELEASE_LIBS)
	dk_set(RELEASE_LIBS ${RELEASE_LIBS})
endif()

if(PLUGINS_FILE)
	dk_set(PLUGINS_FILE ${PLUGINS_FILE})
	dk_replaceAll("${PLUGINS_FILE}" "#include 	\"DKWindow.h\""  ""  PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}"  "\\n"  	"\n" 			 PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}"  ";"  		""  			PLUGINS_FILE)
	dk_fileWrite("${CMAKE_CURRENT_LIST_DIR}/DKPlugins.h" "${PLUGINS_FILE}")
endif()

### CURRENT_PLUGIN ###
dk_basename("${CMAKE_CURRENT_LIST_DIR}")
dk_set(CURRENT_PLUGIN "${dk_basename}")
dk_set(${CURRENT_PLUGIN} 	${CMAKE_SOURCE_DIR})


dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/_CMakeLists.txt_ ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt)


dk_define(DKAPP)
dk_configure(${CMAKE_CURRENT_LIST_DIR})

dk_build(${CMAKE_CURRENT_LIST_DIR})
