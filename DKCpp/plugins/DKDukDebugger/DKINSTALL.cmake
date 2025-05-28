#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDukDebugger ############
dk_depend(DKDuktape)




############ DKDukDebugger ############
dk_set(CURRENT_PLUGIN "DKDukDebugger")
dk_generateCmake(DKDukDebugger)
dk_assets(DKDukDebugger)
dk_set(DKDukDebugger "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKDukDebugger")
dk_configure(${DKDukDebugger})
dk_build(${DKDukDebugger})
