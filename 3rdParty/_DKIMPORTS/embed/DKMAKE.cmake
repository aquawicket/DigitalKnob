#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ embed ############
# https://github.com/batterycenter/embed

dk_import(https://github.com/batterycenter/embed/archive/465081903d97ff1ed05e1fd5d0b3c8032a4a26a6.zip)