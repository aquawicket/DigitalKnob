if(NOT LINUX)
	return()
endif()


### INSTALL ###
DKSET(QUEUE_BUILD ON)
DKSET(CURRENT_DIR /usr)
LINUX_COMMAND(sudo apt install libsystemd-dev)
RASPBERRY_COMMAND(sudo apt install libsystemd-dev)


### LINK ###
DKINCLUDE(/usr/include/systemd)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lsystemd")