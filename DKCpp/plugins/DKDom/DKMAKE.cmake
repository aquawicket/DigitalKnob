#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDom ############
dk_depend(DKDuktape)
dk_depend(DKRml)  #let's make the Dom only require javascript

dk_generateCmake(DKDom)
dk_assets(DKDom)