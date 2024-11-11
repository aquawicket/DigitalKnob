#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


### DEPENDS ###
dk_depend(sdl)	#FIX for DK/DKAndroid.cpp, line:35
dk_depend(DK)
dk_depend(DKArchive)
dk_depend(DKAssets)
dk_depend(DKDebug)
dk_depend(DKDom)
dk_depend(DKDuktape)
dk_depend(DKDuktapeDebugger)
dk_depend(DKRmlAudio)
dk_depend(DKRmlTestElements)
dk_depend(DKRmlVideo)
dk_depend(DKSDLAudio)
dk_depend(DKSDLRml)
dk_depend(DKSDLWindow)
dk_depend(DKThread)
dk_depend(DKWebTest)
dk_depend(DKWindow)
#dk_depend(DKDuktapeDom)
#dk_depend(DKRmlElement)
	
	
	



if(TODO__WORK_IN_PROGRESS)
############ CLEAR CMAKE CACHE ############
dk_clearCmakeCache()
dk_deleteTempFiles()

############ GENERATE APP CMAKE ############
dk_generateAppCmake(${CMAKE_SOURCE_DIR}
	sdl			#FIX for DK/DKAndroid.cpp, line:35
	DK
	DKArchive
	DKAssets
	DKDebug
	DKDom
	DKDuktape
	DKDuktapeDebugger
	DKRmlAudio
	DKRmlTestElements
	DKRmlVideo
	DKSDLAudio
	DKSDLRml
	DKSDLWindow
	DKThread
	DKWebTest
	DKWindow
	#DKDuktapeDom
	#DKRmlElement
)


############ CONFIGURE APP ############
dk_configure(${CMAKE_SOURCE_DIR} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTRIPLE=${TRIPLE})


############ BUILD APP ############
dk_build(${CMAKE_SOURCE_DIR})
endif()