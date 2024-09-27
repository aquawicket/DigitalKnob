#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/floooh/pacman.c.git

#dk_import(https://github.com/floooh/pacman.c.git BRANCH main PATCH)
dk_import(https://github.com/floooh/pacman.c/archive/refs/heads/main.zip PATCH)
