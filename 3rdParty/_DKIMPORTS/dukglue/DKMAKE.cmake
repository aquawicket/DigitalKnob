#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/Aloshi/dukglue.git


dk_depend(duktape)


dk_import(https://github.com/Aloshi/dukglue/archive/c3ec2a463a03a4fa34715aa75273537d39900edb.zip)
#dk_import(https://github.com/Aloshi/dukglue/archive/refs/heads/master.zip)


dk_include(${DUKGLUE}/include)
