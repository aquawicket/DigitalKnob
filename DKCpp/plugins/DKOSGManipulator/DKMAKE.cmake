#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOSGManipulator ############
dk_depend(DKOSGWindow)
#dk_depend(openscenegraph osgManipulator)

dk_generateCmake(DKOSGManipulator)
