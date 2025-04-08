#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### pe-explorer ######
# https://www.pe-explorer.com/


### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	($ENV{DKIMPORTS_DIR}/pe-explorer/dkconfig.txt PE_EXPLORER_IMPORT)
dk_import		(${PE_EXPLORER_IMPORT} NAME PE_EXPLORER)
