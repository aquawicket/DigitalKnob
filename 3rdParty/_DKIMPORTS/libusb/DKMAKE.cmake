#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libusb ############
# https://github.com/libusb/libusb.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libusb/libusb/archive/467b6a88.zip)

# TODO
