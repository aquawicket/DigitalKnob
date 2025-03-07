#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ binutils ############
# https://wiki.termux.com/wiki/ASM

dk_validate(host_triple "dk_host_triple()")

if(ANDROID_HOST)
	dk_installPackage(binutils)
endif()
