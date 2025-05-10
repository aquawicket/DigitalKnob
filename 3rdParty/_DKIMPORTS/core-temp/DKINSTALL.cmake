#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### [core-temp] ######
# https://www.alcpu.com/CoreTemp
# https://www.alcpu.com/CoreTemp/Core-Temp-setup-v1.18.1.0.exe
# https://www.alcpu.com/CoreTemp/CoreTemp32.zip
# https://www.alcpu.com/CoreTemp/CoreTemp64.zip


### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/core-temp/dkconfig.txt")

dk_validate(Host_Triple "dk_Host_Triple()")
if(WIN_X86_HOST)
	dk_set	(CORE_TEMP_IMPORT   ${CORE_TEMP_WIN32_IMPORT})
elseif(WIN_X86_64_HOST)
	dk_set	(CORE_TEMP_IMPORT   ${CORE_TEMP_WIN64_IMPORT})
else()
	dk_set	(CORE_TEMP_IMPORT   ${CORE_TEMP_EXE_IMPORT})
endif()

set(CORE_TEMP_EXE "${CORE_TEMP}/Core Temp.exe")
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_import(${CORE_TEMP_IMPORT} ROOT "${DKTOOLS_DIR}" PATCH)

set(CORE_TEMP_EXE "${CORE_TEMP}/Core Temp.exe")




