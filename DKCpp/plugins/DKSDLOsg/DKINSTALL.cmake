#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLOsg ############
dk_depend(DKSDLWindow)
dk_depend(openscenegraph)




############ DKSDLOsg ############
dk_set(CURRENT_PLUGIN "DKSDLOsg")
dk_generateCmake(DKSDLOsg)
dk_assets(DKSDLOsg)
dk_set(DKSDLOsg "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKSDLOsg")
dk_configure(${DKSDLOsg})
dk_build(${DKSDLOsg})