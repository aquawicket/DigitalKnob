#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/Triggertrap/sun-js

#dk_import(https://github.com/Triggertrap/sun-js.git)
dk_import(https://github.com/Triggertrap/sun-js/archive/refs/heads/master.zip)
