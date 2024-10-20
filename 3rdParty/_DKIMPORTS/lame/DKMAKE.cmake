#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://sourceforge.net/p/lame/svn/HEAD/tree
# https://github.com/lameproject/lame.git


### IMPORT ###
#dk_import(https://sourceforge.net/p/lame/svn/HEAD/tree)
#dk_import(https://github.com/lameproject/lame.git)
dk_import(https://github.com/lameproject/lame/archive/refs/heads/master.zip)


# TODO
