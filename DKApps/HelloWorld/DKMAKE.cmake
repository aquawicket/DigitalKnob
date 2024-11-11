#!/usr/bin/cmake -P
include_guard()	
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ CLEAR CMAKE CACHE ############
#dk_delete(${DK_PROJECT_DIR}/${BUILD_PATH}/CMakeCache.txt)
#dk_delete(${DK_PROJECT_DIR}/${BUILD_PATH}/CMakeFiles)
#dk_clearCmakeCache()
#dk_deleteTempFiles()

############ GENERATE CMakeLists.txt ############
if(NOT DK_PROJECT_DIR MATCHES "DKCMake")
	dk_generateAppCmake(${DK_PROJECT_DIR})
endif()

############ CONFIGURE APP ############
#dk_configure(${DK_PROJECT_DIR} 
#	-DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} 
#	-DDKCMAKE_FUNCTIONS_DIR_=${DKCMAKE_FUNCTIONS_DIR_} 
#	-DTRIPLE=${TRIPLE})
	
############ BUILD APP ############
#dk_build(${DK_PROJECT_DIR})
