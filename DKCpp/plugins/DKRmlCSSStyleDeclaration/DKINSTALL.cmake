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


############ DKRmlCSSStyleDeclaration ############
# [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
dk_depend(DKCSSStyleDeclaration)





############ DKRmlCSSStyleDeclaration ############
dk_set(CURRENT_PLUGIN "DKRmlCSSStyleDeclaration")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
#dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
#dk_configure(${${CURRENT_PLUGIN}})
#dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
#dk_build(${${CURRENT_PLUGIN}})
dk_configure(${CMAKE_CURRENT_LIST_DIR})
dk_build(${CMAKE_CURRENT_LIST_DIR})