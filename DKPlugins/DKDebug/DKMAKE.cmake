#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKDebug ############
#dk_depend(backward-cpp)
dk_depend(stackwalker)
dk_depend(DKAssets)
dk_depend(DKCurl)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()

if(MSVC)
	dk_copy(${STACKWALKER}/StackWalker/StackWalker.cpp ${DKPLUGINS_DIR}/DKDebug/StackWalker.cpp)
	WIN_dk_include(${STACKWALKER}/StackWalker)
else()
	dk_delete(${DKPLUGINS_DIR}/DKDebug/StackWalker.cpp NO_HALT)
endif()

dk_generateCmake(DKDebug)
dk_assets(DKDebug)

if(DKAPP)
	if(WIN)
		LIST(APPEND RELEASE_LINK_FLAGS /DEBUG)
	endif()
endif()