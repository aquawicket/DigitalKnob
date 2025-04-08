#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ sun-js ############
# https://github.com/Triggertrap/sun-js

dk_load(dk_builder)

#dk_import(https://github.com/Triggertrap/sun-js.git)
dk_import(https://github.com/Triggertrap/sun-js/archive/refs/heads/master.zip)
