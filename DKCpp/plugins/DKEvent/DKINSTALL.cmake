#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKEvent ############
dk_depend(DKInterface)





############ DKEvent ############
dk_set(CURRENT_PLUGIN "DKEvent")
dk_generateCmake(DKEvent)
dk_assets(DKEvent)

dk_set(DKEvent "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKEvent")
dk_configure(${DKEvent})
dk_build(${DKEvent})