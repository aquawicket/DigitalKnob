#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKOSGWidget ############
dk_depend(DKOSGWindow)
#dk_depend(openscenegraph osgWidget)

dk_generateCmake(DKOSGWidget)
