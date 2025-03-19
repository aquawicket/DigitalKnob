#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ content ############
#### MDN Web Docs ####
# https://github.com/mdn/content.git
# https://www.peterbe.com/plog/how-to-get-all-of-mdn-web-docs-running-locally
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/mdn/content/archive/50c8e290.zip)

# TODO
#cd content
#yarn install
#yarn start
