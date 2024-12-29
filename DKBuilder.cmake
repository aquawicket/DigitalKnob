#!/usr/bin/cmake -P
if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR_}")
	set(DKCMAKE_FUNCTIONS_DIR_ "DKCMake/functions/")
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### Load Main Program ######
dk_source(dk_buildMain)
dk_buildMain()