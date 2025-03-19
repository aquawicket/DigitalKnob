#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKEventTarget ############
dk_depend(DKInterface)
dk_depend(DKEventListener)
dk_depend(DKEvent)

dk_generateCmake(DKEventTarget)
dk_assets(DKEventTarget)
