#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ lame ############
# https://sourceforge.net/p/lame/svn/HEAD/tree
# https://github.com/lameproject/lame.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/lameproject/lame/archive/1f5cc948.zip)


# TODO
