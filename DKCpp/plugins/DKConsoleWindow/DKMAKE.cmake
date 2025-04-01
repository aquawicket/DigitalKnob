#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKConsoleWindow ############
#FIXME:  Unix probobly needs curses
dk_depend(DKWindow)
dk_depend(DKFocusEvent)
dk_depend(DKMouseEvent)
dk_depend(DKWheelEvent)
dk_depend(DKKeyboardEvent)

dk_generateCmake(DKConsoleWindow)
dk_assets(DKConsoleWindow)