#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ gstreamer ############
# https://gitlab.freedesktop.org/gstreamer/gstreamer.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://gitlab.freedesktop.org/gstreamer/gstreamer/-/archive/7c3ee65d/gstreamer-7c3ee65d.zip)


# TODO
