#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ quickjs ############
# https://github.com/bellard/quickjs.git

dk_load(dk_builder)

#dk_import(https://github.com/bellard/quickjs.git)
dk_import(https://github.com/bellard/quickjs/archive/refs/heads/master.zip)

# TODO
