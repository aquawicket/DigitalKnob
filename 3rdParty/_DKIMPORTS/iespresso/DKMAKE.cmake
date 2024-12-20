#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ iespresso ############
# https://ss64.com/nt/iexpress.html
# https://www.partitionwizard.com/partitionmanager/bat-to-exe.html

dk_load(dk_builder)

dk_import(https://github.com/markgollnick/iespresso/archive/57c23127.zip PATCH)
