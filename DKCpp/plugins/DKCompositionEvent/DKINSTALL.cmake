#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKCompositionEvent ############
dk_depend(DK)
dk_depend(DKUIEvent)



############ DKCompositionEvent ############
dk_set(CURRENT_PLUGIN "DKCompositionEvent")
dk_generateCmake(DKCompositionEvent)
dk_assets(DKCompositionEvent)

dk_set(DKCompositionEvent "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKCompositionEvent")
dk_configure(${DKCompositionEvent})
dk_build(${DKCompositionEvent})