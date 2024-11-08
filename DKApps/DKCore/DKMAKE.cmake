#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ CLEAR CMAKE CACHE ############
dk_clearCmakeCache()
dk_deleteTempFiles()


############ GENERATE APP CMAKE ############
dk_generateAppCmake(${CMAKE_SOURCE_DIR}
	zlib
	DK
)


############ CONFIGURE APP ############
dk_configure(${CMAKE_SOURCE_DIR} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTRIPLE=${TRIPLE})


############ BUILD APP ############
dk_build(${CMAKE_SOURCE_DIR})
