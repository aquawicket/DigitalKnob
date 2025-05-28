#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKRmlInterface ############
dk_depend(rmlui)
dk_depend(DKCurl)
dk_depend(DKFile)
dk_depend(DKWindow)
dk_depend(DKXml)
dk_depend(tidy-html5)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()
if(HAVE_DKSDLRmlDocument)
	dk_depend(DKSDLRmlDocument)	# Linux FIX:
endif()


############ DKRmlInterface ############
dk_set(CURRENT_PLUGIN "DKRmlInterface")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})
