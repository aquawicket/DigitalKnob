#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DK_PROJECT_DIR ############
if(NOT DK_PROJECT_DIR)
	dk_set(DK_PROJECT_DIR ${CMAKE_SOURCE_DIR})
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH")
endif()
dk_printVar(DK_PROJECT_DIR)

############ CLEAR CMAKE CACHE ############
dk_delete(${DK_PROJECT_DIR}/${BUILD_PATH}/CMakeCache.txt)
dk_delete(${DK_PROJECT_DIR}/${BUILD_PATH}/CMakeFiles)
dk_clearCmakeCache()
dk_deleteTempFiles()

############ GENERATE APP CMAKE ############
if(NOT DK_PROJECT_DIR MATCHES "DKCMake")
dk_generateAppCmake(${DK_PROJECT_DIR}
	psapi
	pdh.lib
	dxva2
	duktape
	sdl
	sdl_ttf
	DK
	DKDuktape
	DKDuktapeDebugger
	DKArchive
	DKAssets
	DKFmt
	#DKDuktapeDom
	DKFile
	DKSDLText
	DKSDLWindow
	DKWindow)
endif()

############ CONFIGURE APP ############
dk_configure(${DK_PROJECT_DIR} 
	-DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} 
	-DTRIPLE=${TRIPLE} 
	${PSAPI_CMAKE} 
	${PDHLIB_CMAKE} 
	${DXVA2_CMAKE})

############ BUILD APP ############
dk_build(${DK_PROJECT_DIR})
