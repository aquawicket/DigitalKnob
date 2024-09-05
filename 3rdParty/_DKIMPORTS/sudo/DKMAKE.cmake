include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.sudo.ws


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