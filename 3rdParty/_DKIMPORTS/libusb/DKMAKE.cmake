#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libusb ############
# https://github.com/libusb/libusb.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libusb/libusb/archive/467b6a88.zip)

# TODO
