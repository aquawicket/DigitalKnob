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


dk_DKBRANCH_DIR()
dk_Target_Tuple()

### Target_App_Dir ###
dk_set(Target_App_Dir 		"${CMAKE_CURRENT_LIST_DIR}")
dk_basename("${Target_App_Dir}")

### DEPEND ###
#dk_depend(netsurf)
dk_depend(webref)
dk_depend(DKDuktape)
dk_depend(DK)
dk_depend(DKAssets)
###### Standard Interfaces ######
dk_depend(DKInterface)
dk_depend(DKConsole)
dk_depend(DKEvent)
dk_depend(DKEventListener)
dk_depend(DKEventTarget)
dk_depend(DKCustomEvent)
dk_depend(DKNonElementParentNode)		# Mixin
dk_depend(DKDocument)
dk_depend(DKScreen)
dk_depend(DKWindow)
dk_depend(DKUIEvent)
dk_depend(DKFocusEvent)
dk_depend(DKMouseEvent)
dk_depend(DKWheelEvent)
dk_depend(DKInputEvent)
dk_depend(DKKeyboardEvent)
dk_depend(DKCompositionEvent)
dk_depend(DKDragEvent)
dk_depend(DKNavigator)
dk_depend(DKURL)
dk_depend(DKLocation)
dk_depend(DKCSSStyleDeclaration)
dk_depend(DKNode)
dk_depend(DKInnerHTML)					# Mixin
dk_depend(DKElementCSSInlineStyle)		# Mixin
dk_depend(DKElement)
dk_depend(DKHTMLCollection)
dk_depend(DKHTMLElement)
dk_depend(DKHTMLBodyElement)
dk_depend(DKHTMLImageElement)
###### DigitalKnob Interfaces ######
dk_depend(DKConsoleWindow)
dk_depend(DKSDLWindow)
dk_depend(DKSDLRmlDocument)
dk_depend(DKRmlInterface)
dk_depend(DKRmlEventListener)
dk_depend(DKRmlEventTarget)
dk_depend(DKRmlLocation)
dk_depend(DKRmlCSSStyleDeclaration)
dk_depend(DKRmlNode)
dk_depend(DKRmlElementCSSInlineStyle)	# Mixin
dk_depend(DKRmlInnerHTML)				# Mixin
dk_depend(DKRmlElement)
dk_depend(DKRmlNonElementParentNode)	# Mixin
dk_depend(DKRmlDocument)
dk_depend(DKRmlHTMLElement)
dk_depend(DKWebTest)


### TODO: Add Plugins.h file generation ###
#if(DKINCLUDES_LIST)
#	dk_set(DKINCLUDES_LIST 	${DKINCLUDES_LIST})
#endif()
if(DKDEFINES_LIST)
	dk_set(DKDEFINES_LIST	${DKDEFINES_LIST})
endif()
if(DKLINKDIRS_LIST)
	dk_set(DKLINKDIRS_LIST 	${DKLINKDIRS_LIST})
endif()
if(LIBS)
	dk_set(LIBS 			${LIBS})
endif()
if(DEBUG_LIBS)
	dk_set(DEBUG_LIBS		${DEBUG_LIBS})
endif()
if(RELEASE_LIBS)
	dk_set(RELEASE_LIBS 	${RELEASE_LIBS})
endif()
if(PLUGINS_FILE)
	dk_set(PLUGINS_FILE		${PLUGINS_FILE})
endif()



#if(PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}" "#include 	\"DKWindow.h\""  ""  PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}"  "\\n"  	"\n" 			 PLUGINS_FILE)
	dk_replaceAll("${PLUGINS_FILE}"  ";"  		""  			PLUGINS_FILE)
	dk_fileWrite("${Target_App_Dir}/DKPlugins.h" "${PLUGINS_FILE}")
#endif()
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

dk_set(CURRENT_PLUGIN		"${dk_basename}")
dk_set(${CURRENT_PLUGIN}	"${CMAKE_SOURCE_DIR}")
dk_set(DKCPP_PLUGINS_DIR 	"${DKCPP_PLUGINS_DIR}")

dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/_CMakeLists.txt_ ${Target_App_Dir}/CMakeLists.txt)

dk_define(DKAPP)

dk_configure(${Target_App_Dir})

dk_build(${Target_App_Dir})