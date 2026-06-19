#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKDebug ############
#dk_depend(backward-cpp)
dk_depend(stackwalker)
dk_depend(DKAssets)
dk_depend(DKCurl)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_validate(DKCef "dk_depend(DKCef)")
endif()

if(MSVC AND STACKWALKER)
	dk_copy(${STACKWALKER}/StackWalker/StackWalker.cpp ${DKCPP_PLUGINS_DIR}/DKDebug/StackWalker.cpp)
	dk_include(${STACKWALKER}/StackWalker)
else()
	dk_delete(${DKCPP_PLUGINS_DIR}/DKDebug/StackWalker.cpp NO_HALT)
endif()



############ DKDebug ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()



if(DKAPP)
	if(Windows)
		LIST(APPEND RELEASE_LINK_FLAGS /DEBUG)
	endif()
endif()