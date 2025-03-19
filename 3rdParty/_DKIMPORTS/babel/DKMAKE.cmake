#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### babel ######
# https://github.com/babel/babel.git
# https://unpkg.com/@babel/standalone@7.14.4/babel.min.js

### IMPORT ###
dk_import(https://unpkg.com/@babel/standalone@7.14.4/babel.min.js)
