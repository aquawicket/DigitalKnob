#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKEventListener ############
dk_depend(DKEvent)




############ DKEventListener ############
dk_set(CURRENT_PLUGIN "DKEventListener")
dk_generateCmake(DKEventListener)
dk_assets(DKEventListener)

dk_set(DKEventListener "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKEventListener")
dk_configure(${DKEventListener})
dk_build(${DKEventListener})
