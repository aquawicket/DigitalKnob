#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKUIEvent ############
# [IDL] https://w3c.github.io/uievents/#idl-uievent
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
dk_depend(DKEvent)

dk_generateCmake(DKUIEvent)
dk_assets(DKUIEvent)
