#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKHTMLBodyElement ############
# [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement

dk_depend(DKHTMLElement)




############ DKHTMLBodyElement ############
dk_set(CURRENT_PLUGIN "DKHTMLBodyElement")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/${CURRENT_PLUGIN}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})
