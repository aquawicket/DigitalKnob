#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# crosswalk


### DEPEND ###
#dk_depend(openjdk)
dk_depend(ant)
dk_depend(nodejs)


### INSTALL ###
WIN_dk_queueCommand("npm install -g crosswalk-app-tools")