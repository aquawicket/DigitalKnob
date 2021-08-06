if(NOT LINUX AND NOT RASPBERRY)
	return()
endif()


### INSTALL ###
DKSET(QUEUE_BUILD ON)
DKSET(CURRENT_DIR /usr)
LINUX_COMMAND(sudo apt install libxrandr-dev)
RASPBERRY_COMMAND(sudo apt install libxrandr-dev)


### LINK ###
## DKINCLUDE(/usr/include/X11)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXrandr")