#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLVideo ############
if(WIN)
	RETURN()
endif()

dk_depend(waave)
dk_depend(DKVideo)
dk_depend(DKSDLWindow)

dk_generateCmake(DKSDLVideo)
dk_assets(DKSDLVideo)
