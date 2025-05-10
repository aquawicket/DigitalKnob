#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ binutils ############
# https://wiki.termux.com/wiki/ASM

dk_validate(Host_Triple "dk_Host_Triple()")

if(ANDROID_HOST)
	dk_installPackage(binutils)
endif()
