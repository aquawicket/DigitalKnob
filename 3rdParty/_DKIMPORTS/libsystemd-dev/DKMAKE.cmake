include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libsystemd-dev)
	dk_return()
endif()

### INSTALL ###
#dk_cd(/usr)
dk_command(${SUDO} apt -y install libsystemd-dev)


### LINK ###
dk_include(/usr/include/systemd)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lsystemd")
