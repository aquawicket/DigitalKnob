if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libsystemd-dev)


### LINK ###
dk_include(/usr/include/systemd)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lsystemd")