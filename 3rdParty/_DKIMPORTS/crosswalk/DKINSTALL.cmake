#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ crosswalk ############

dk_load(dk_builder)

### DEPEND ###
#dk_depend(openjdk)
dk_depend(ant)
dk_depend(nodejs)


### INSTALL ###
if(Windows)
	dk_queueCommand("npm install -g crosswalk-app-tools")
endif()