#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.sudo.ws

if(WIN_HOST)
	return()
endif()

if(EXISTS ${SUDO_EXE})
	return()
endif()


dk_findProgram(SUDO_EXE sudo)
if(EXISTS ${SUDO_EXE})
	dk_set(SUDO_EXE ${SUDO_EXE})   # set it globally
	return()
endif()




if(NOT EXISTS ${SUDO_EXE})
	dk_error("Could not file SUDO_EXE:${SUDO_EXE}")
endif()