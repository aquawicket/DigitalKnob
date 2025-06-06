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

### Target_App_Dir ###
dk_set(Target_App_Dir "${CMAKE_CURRENT_LIST_DIR}")
dk_assertPath(Target_App_Dir)

### DEPEND ###
dk_depend(imagemagick)
dk_depend(sdl)	#FIX for DK/DKAndroid.cpp, line:35
dk_depend(DK)
dk_depend(DKArchive)
dk_depend(DKAssets)
dk_depend(DKDebug)
dk_depend(DKDom)
dk_depend(DKDuktape)
dk_depend(DKDuktapeDebugger)
#dk_depend(DKRmlAudio)
dk_depend(DKRmlTestElements)
dk_depend(DKRmlVideo)
dk_depend(DKSDLAudio)
dk_depend(DKSDLRml)
dk_depend(DKSDLWindow)
dk_depend(DKThread)
dk_depend(DKWebTest)
dk_depend(DKWindow)
#dk_depend(DKDuktapeDom)
#dk_depend(DKRmlElement)

### CURRENT_PLUGIN ###
dk_basename("${Target_App_Dir}")
dk_set(CURRENT_PLUGIN "${dk_basename}")
dk_set(${CURRENT_PLUGIN} 	${CMAKE_SOURCE_DIR})


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
#if(${CURRENT_PLUGIN} STREQUAL DK OR BUILD_STATIC_LIBS)
	file(GLOB HEADER_FILES RELATIVE ${DKCPP_PLUGINS_DIR} ${CMAKE_CURRENT_LIST_DIR}/*.h)
	foreach(header ${HEADER_FILES})
		if(NOT PLUGINS_FILE MATCHES "${header}")
			dk_info("Adding ${header} to header file.")
			dk_set(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
		endif()
		#if(NOT PLUGINS_FILE MATCHES "DKHAVE_${plugin_name}")
		#	dk_info("Adding #define DKHAVE_${plugin_name} 1 to header file.")
		#	dk_set(PLUGINS_FILE ${PLUGINS_FILE} "#define DKHAVE_${plugin_name} 1\\n")
		#endif()
	endforeach()
#endif()


dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/_CMakeLists.txt_ ${Target_App_Dir}/CMakeLists.txt)

dk_define(DKAPP)

dk_configure(${Target_App_Dir})

dk_build(${Target_App_Dir})
