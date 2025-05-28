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




############ DKConsoleWindow ############
dk_set(CURRENT_PLUGIN "DKConsoleWindow")
dk_generateCmake(DKConsoleWindow)
dk_assets(DKConsoleWindow)

dk_set(DKConsoleWindow "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKConsoleWindow")
dk_configure(${DKConsoleWindow})
dk_build(${DKConsoleWindow})