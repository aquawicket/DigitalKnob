#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKBuild ############
dk_depend(DKCurl)
dk_depend(DKArchive)
if(WIN)
	dk_depend(imagemagick)
endif()

dk_assets(DKBuild)