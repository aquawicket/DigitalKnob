#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pestudio ############
# https://www.winitor.com/
# https://www.winitor.com/tools/pestudio/current/pestudio-9.59.zip

dk_import(https://www.winitor.com/tools/pestudio/current/pestudio-9.59.zip)
