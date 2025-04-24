#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Load Main Program ######
dk_source(dk_buildMain)
dk_buildMain()