#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKPlugins ############
# [IDL] https://w3c.github.io/uievents/#idl-focusevent
# [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
dk_depend(DKUIEvent)

dk_generateCmake(DKFocusEvent)
dk_assets(DKFocusEvent)