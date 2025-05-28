#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDOM_Window ############
dk_depend(uriparser)
dk_depend(DKEventTarget)



############ DKDOM_Window ############
dk_set(CURRENT_PLUGIN "DKDOM_Window")
dk_generateCmake(DKDOM_Window)
dk_assets(DKDOM_Window)
dk_set(DKDOM_Window "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKDOM_Window")
dk_configure(${DKDOM_Window})
dk_build(${DKDOM_Window})