#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ os.js ############
# https://github.com/os-js/OS.js.git

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/os-js/OS.js.git)
dk_import(https://github.com/os-js/OS.js/archive/refs/heads/master.zip)

# TODO
