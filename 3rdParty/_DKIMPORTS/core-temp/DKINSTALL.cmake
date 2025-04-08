#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### [core-temp] ######
# https://www.alcpu.com/CoreTemp/
# https://www.alcpu.com/CoreTemp/Core-Temp-setup-v1.18.1.0.exe
# https://www.alcpu.com/CoreTemp/CoreTemp32.zip
# https://www.alcpu.com/CoreTemp/CoreTemp64.zip

### DEPENDS ###
#dk_depend(depend_name)

### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	($ENV{DKIMPORTS_DIR}/core-temp/dkconfig.txt CORE_TEMP_DL)
dk_getFileParam	($ENV{DKIMPORTS_DIR}/core-temp/dkconfig.txt CORE_TEMP_WIN32_DL)
dk_getFileParam	($ENV{DKIMPORTS_DIR}/core-temp/dkconfig.txt CORE_TEMP_WIN64_DL)

#dk_validate(host_triple "dk_host_triple()")
#if(WIN_X86_HOST)
#	dk_set	(CORE_TEMP_DL   ${CORE_TEMP_WIN32_DL})
#elseif(WIN_X86_64_HOST)
#	dk_set	(CORE_TEMP_DL   ${CORE_TEMP_WIN64_DL})
#endif()

###### OVERRIDE ######
dk_import	(${CORE_TEMP_DL})



