#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### Load Main Program ######
dk_source(dk_buildMain)
dk_buildMain()