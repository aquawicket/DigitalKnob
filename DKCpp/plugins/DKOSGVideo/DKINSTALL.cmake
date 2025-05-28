#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOSGVideo ############
dk_depend(DKOSGWindow)
#dk_depend(openscenegraph osgdb_ffmpeg)





############ DKOSGVideo ############
dk_set(CURRENT_PLUGIN "DKOSGVideo")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/${CURRENT_PLUGIN}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})
