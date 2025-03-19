#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ command_line_tools ############
#command line tools for apple

dk_load(dk_builder)

#TODO

#-I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include 
#-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"