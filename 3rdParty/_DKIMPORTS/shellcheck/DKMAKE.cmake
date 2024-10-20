#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/koalaman/shellcheck.git
# https://github.com/koalaman/shellcheck/archive/refs/heads/master.zip



#pkg install shellcheck
dk_installPackage(shellcheck)