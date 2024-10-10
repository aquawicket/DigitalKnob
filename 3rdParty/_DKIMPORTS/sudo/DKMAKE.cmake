#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.sudo.ws

if(WIN32)
	return()
endif()

if(EXISTS ${SUDO_EXE})
	return()
endif()


dk_findProgram(SUDO_EXE sudo)
if(NOT EXISTS ${SUDO_EXE})
	dk_set(SUDO_EXE "")
	dk_unset(SUDO_EXE)
endif()



dk_set(SUDO_EXE ${SUDO_EXE})   # set it globally
message("SUDO_EXE = ${SUDO_EXE}")
