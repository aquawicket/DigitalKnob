#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/koalaman/shellcheck.git
# https://github.com/koalaman/shellcheck/archive/refs/heads/master.zip



#pkg install shellcheck
dk_installPackage(shellcheck)