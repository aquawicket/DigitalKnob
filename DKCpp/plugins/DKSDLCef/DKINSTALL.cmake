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

if(IOSSIM)
	RETURN()
endif()

dk_depend(DKSDLWindow)
dk_depend(DKCef)
dk_depend(DKCefChild)
dk_depend(DKAssets)

dk_generateCmake(DKSDLCef)
