#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKRmlTestElements ############
dk_depend(DKRml)
#if(HAVE_DKDuktape)
#	dk_depend(DKDuktape)
#endif()

dk_generateCmake(DKRmlTestElements)
dk_assets(DKRmlTestElements)
