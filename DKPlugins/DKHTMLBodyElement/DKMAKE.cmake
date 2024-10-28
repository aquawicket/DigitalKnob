#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKHTMLBodyElement ############
# [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement

dk_depend(DKHTMLElement)

dk_generateCmake(DKHTMLBodyElement)
dk_assets(DKHTMLBodyElement)
