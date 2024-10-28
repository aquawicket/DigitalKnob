#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKConsoleWindow ############
#FIXME:  Unix probobly needs curses
dk_depend(DKWindow)
dk_depend(DKFocusEvent)
dk_depend(DKMouseEvent)
dk_depend(DKWheelEvent)
dk_depend(DKKeyboardEvent)

dk_generateCmake(DKConsoleWindow)
dk_assets(DKConsoleWindow)