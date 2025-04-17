#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe


dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		("$ENV{DKIMPORTS_DIR}/ida/dkconfig.txt" IDA_IMPORT)
dk_validate			(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_basename			(${IDA_IMPORT} IDA_DL_FILE)
dk_importVariables	(${IDA_IMPORT} NAME IDA)
dk_set				(IDA64_EXE "$ENV{DKTOOLS_DIR}/Ida/ida64.exe")

if(EXISTS "${IDA64_EXE}")
	return()
endif()

dk_download(${IDA_IMPORT} $ENV{DKDOWNLOAD_DIR})
dk_assertVar(IDA_DL_FILE)
execute_process(COMMAND "$ENV{DKDOWNLOAD_DIR}/${IDA_DL_FILE}" --prefix "$ENV{DKTOOLS_DIR}/Ida" --mode unattended)
