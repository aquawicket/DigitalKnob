#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
## https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip/download


### DEPEND ###
dk_depend(boost boost_system)
dk_depend(boost boost_thread)


### IMPORT ###
dk_import(https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip)


### LINK ###
dk_include(${THREADPOOL})
