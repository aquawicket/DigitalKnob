#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ js-yaml ############
# https://github.com/nodeca/js-yaml.git
# https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/nodeca/js-yaml/archive/0d3ca7a2.zip)
