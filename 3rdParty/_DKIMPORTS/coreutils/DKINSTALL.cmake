#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ coreutils ############
# https://formulae.brew.sh/formula/coreutils

if(NOT Mac_Host)
	dk_undepend(coreutils)
	dk_return()
endif()

dk_load(dk_builder)

dk_installPackage(coreutils)
