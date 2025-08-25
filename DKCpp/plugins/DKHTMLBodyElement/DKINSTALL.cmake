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


dk_importVariables(INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKHTMLBodyElement ############
# [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement

dk_depend(DKHTMLElement)




############ DKHTMLBodyElement ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()
