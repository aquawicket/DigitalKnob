#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ crosswalk ############
# crosswalk
dk_load(dk_builder)

### DEPEND ###
#dk_depend(openjdk)
dk_depend(ant)
dk_depend(nodejs)


### INSTALL ###
if(WIN)
	dk_queueCommand("npm install -g crosswalk-app-tools")
endif()