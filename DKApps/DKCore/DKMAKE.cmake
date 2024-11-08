#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ CLEAR CMAKE CACHE ############
dk_clearCmakeCache()
dk_deleteTempFiles()


############ GENERATE APP CMAKE ############
set(DK_PROJECT_DIR ${CMAKE_SOURCE_DIR})
dk_generateAppCmake(${DK_PROJECT_DIR})


############ CONFIGURE APP ############
dk_basename(${DK_PROJECT_DIR} APP_NAME)
dk_set(CURRENT_PLUGIN ${APP_NAME})
dk_set(${CURRENT_PLUGIN} ${CMAKE_SOURCE_DIR})
dk_set(${CURRENT_PLUGIN}_CONFIG_DIR ${CMAKE_SOURCE_DIR}/${CONFIG_PATH})
dk_printVar(${CURRENT_PLUGIN}_CONFIG_DIR)
dk_configure(${CMAKE_SOURCE_DIR} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTRIPLE=${TRIPLE})


############ BUILD APP ############
dk_build(${CMAKE_SOURCE_DIR})
