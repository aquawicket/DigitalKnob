#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ lz4 ############
# https://github.com/lz4/lz4.git

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/lz4/lz4.git BRANCH dev)
dk_import(https://github.com/lz4/lz4/archive/refs/heads/dev.zip)


# TODO
