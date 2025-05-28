#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLCef ############
if(NOT HAVE_DKCef)
	RETURN()
endif()

if(Android)
	RETURN()
endif()

if(Iossim)
	RETURN()
endif()

dk_depend(DKSDLWindow)
dk_depend(DKCef)
dk_depend(DKCefChild)
dk_depend(DKAssets)





############ DKSDLCef ############
dk_set(CURRENT_PLUGIN "DKSDLCef")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})
