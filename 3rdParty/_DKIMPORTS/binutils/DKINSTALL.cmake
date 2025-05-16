#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ binutils ############
# https://wiki.termux.com/wiki/ASM

dk_validate(Host_Tuple "dk_Host_Tuple()")

if(Android_Host)
	dk_installPackage(binutils)
endif()
