#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/kinbei/RmlUiEditor.git


### IMPORT ###
#dk_import(https://github.com/kinbei/RmlUiEditor/archive/3c8b1b239a486ee17401392e1854004b3e3ce6a4.zip)
#dk_import(https://github.com/kinbei/RmlUiEditor.git)
dk_import(https://github.com/kinbei/RmlUiEditor/archive/refs/heads/master.zip)

# TODO
