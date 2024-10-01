#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/chriskohlhoff/asio.git


### IMPORT ###
dk_import(https://github.com/chriskohlhoff/asio/archive/efdc25ab99786101351a5afb39f01dfaf0781401.zip)
#dk_import(https://github.com/chriskohlhoff/asio/archive/refs/heads/master.zip)



# TODO