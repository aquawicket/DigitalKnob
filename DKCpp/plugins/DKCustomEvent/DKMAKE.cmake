#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKCustomEvent ############
# [IDL] https://dom.spec.whatwg.org/#interface-customevent
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
dk_depend(DKEvent)

dk_generateCmake(DKCustomEvent)
dk_assets(DKCustomEvent)