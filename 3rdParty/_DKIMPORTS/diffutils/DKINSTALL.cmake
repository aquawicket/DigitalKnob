#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ diffutils ############
# https://packages.msys2.org/base/diffutils


dk_validate(MSYS2 "dk_depend(msys2)")
dk_installPackage(diffutils)
