if(NOT LINUX AND NOT RASPBERRY)
	return()
endif()


### INSTALL ###
DKSET(QUEUE_BUILD ON)
DKSET(CURRENT_DIR /usr)
LINUX_COMMAND(sudo apt install libasound2-dev)


### LINK ###
DKINCLUDE(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")