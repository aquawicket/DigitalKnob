#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/libusb/libusb.git


### IMPORT ###
#dk_import(https://github.com/libusb/libusb/archive/4622bfcf44db373c53502e3fe873bd611e8332f6.zip)
#dk_import(https://github.com/libusb/libusb.git)
dk_import(https://github.com/libusb/libusb/archive/refs/heads/master.zip)

# TODO
