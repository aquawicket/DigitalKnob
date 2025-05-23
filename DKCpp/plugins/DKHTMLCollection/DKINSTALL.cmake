#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKHTMLCollection ############
# [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
dk_depend(DKInterface)

dk_generateCmake(DKHTMLCollection)
dk_assets(DKHTMLCollection)
