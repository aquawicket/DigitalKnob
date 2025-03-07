#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ shellcheck ############
# https://github.com/koalaman/shellcheck.git
# https://github.com/koalaman/shellcheck/archive/refs/heads/master.zip

dk_load(dk_builder)

#pkg install shellcheck
dk_installPackage(shellcheck)