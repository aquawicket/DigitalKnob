#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOSGCef ############
dk_enable(DKCef)

dk_depend(DKOSGWindow)
dk_depend(DKCef)
dk_depend(DKCefChild)
dk_depend(DKAssets)

dk_generateCmake(DKOSGCef)
