#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.sudo.ws

if(WIN_HOST)
	return()
endif()

if(EXISTS ${SUDO})
	return()
endif()


dk_findProgram(SUDO sudo)
if(EXISTS ${SUDO})
	dk_set(SUDO ${SUDO})   # set it globally
	return()
endif()




if(NOT EXISTS ${SUDO})
	dk_error("Could not file SUDO:${SUDO}")
endif()