#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe


dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	($ENV{DKIMPORTS_DIR}/ida/dkconfig.txt IDA_IMPORT)
dk_validate		(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_import		(${IDA_IMPORT} NAME "IDA" ROOT "$ENV{DKTOOLS_DIR}")
