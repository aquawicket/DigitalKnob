#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDom ############
dk_depend(DKDuktape)
dk_depend(DKRml)  #let's make the Dom only require javascript




############ DKDom ############
dk_set(CURRENT_PLUGIN "DKDom")
dk_generateCmake(DKDom)
dk_assets(DKDom)

dk_set(DKDom "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKDom")
dk_configure(${DKDom})
dk_build(${DKDom})