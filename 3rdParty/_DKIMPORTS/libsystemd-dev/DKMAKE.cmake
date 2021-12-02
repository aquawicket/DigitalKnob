if(NOT CMAKE_HOST_UNIX)
	return()
endif()

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libsystemd-dev)


### LINK ###
DKINCLUDE(/usr/include/systemd)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lsystemd")