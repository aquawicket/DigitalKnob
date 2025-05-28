#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKElement ############
dk_depend(DKNode)




############ DKElement ############
dk_set(CURRENT_PLUGIN "DKElement")
dk_generateCmake(DKElement)
dk_assets(DKElement)

dk_set(DKElement "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKElement")
dk_configure(${DKElement})
dk_build(${DKElement})