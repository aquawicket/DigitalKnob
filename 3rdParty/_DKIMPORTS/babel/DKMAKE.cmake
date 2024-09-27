#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/babel/babel.git
# https://unpkg.com/@babel/standalone@7.14.4/babel.min.js


### IMPORT ###
#dk_import(https://github.com/babel/babel.git)
dk_import(https://unpkg.com/@babel/standalone@7.14.4/babel.min.js)
