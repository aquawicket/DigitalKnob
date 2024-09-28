#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/koalaman/shellcheck.git
# https://github.com/koalaman/shellcheck/archive/refs/heads/master.zip


###### TERMUX ######
pkg install shellcheck