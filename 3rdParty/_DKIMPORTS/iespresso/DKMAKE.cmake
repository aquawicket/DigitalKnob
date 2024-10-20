#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://ss64.com/nt/iexpress.html
# https://www.partitionwizard.com/partitionmanager/bat-to-exe.html

dk_import(https://github.com/markgollnick/iespresso/archive/57c23127a1d25614d44d7bfe289514dc94ddc3df.zip PATCH)
#dk_import(https://github.com/markgollnick/iespresso/archive/refs/heads/master.zip PATCH)