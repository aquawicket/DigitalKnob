#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ iespresso ############
# https://ss64.com/nt/iexpress.html
# https://www.partitionwizard.com/partitionmanager/bat-to-exe.html

#dk_validate(host_triple "dk_host_triple()")

dk_import(https://github.com/markgollnick/iespresso/archive/57c23127.zip PATCH)
