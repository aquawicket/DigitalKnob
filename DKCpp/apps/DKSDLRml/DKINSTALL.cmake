#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

dk_depend(imagemagick)
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



