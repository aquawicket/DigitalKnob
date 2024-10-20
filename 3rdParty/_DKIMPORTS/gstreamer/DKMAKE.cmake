#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://gitlab.freedesktop.org/gstreamer/gstreamer.git


### IMPORT ###
#dk_import(https://gitlab.freedesktop.org/gstreamer/gstreamer.git)
dk_import(https://gitlab.freedesktop.org/gstreamer/gstreamer/-/archive/main/gstreamer-main.zip)


# TODO
