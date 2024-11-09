#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



if(NOT DK_PROJECT_DIR)
	dk_set(DK_PROJECT_DIR ${CMAKE_SOURCE_DIR})
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH")
endif()
dk_printVar(DK_PROJECT_DIR)

############ CLEAR CMAKE CACHE ############
dk_clearCmakeCache()
dk_deleteTempFiles()


############ GENERATE APP CMAKE ############
if(NOT DK_PROJECT_DIR MATCHES "DKCMake")
dk_warning("!!!! OVERWRITTING DK_PROJECT_DIR:${DK_PROJECT_DIR} !!!")
dk_pause()
dk_generateAppCmake(${DK_PROJECT_DIR}
	zlib
	DK
)  
dk_pause()
endif()


############ CONFIGURE APP ############
dk_configure(${DK_PROJECT_DIR} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTRIPLE=${TRIPLE})


############ BUILD APP ############
dk_build(${DK_PROJECT_DIR})
