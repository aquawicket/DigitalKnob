if(NOT LINUX AND NOT RASPBERRY)
	return()
endif()


### INSTALL ###
DKSET(QUEUE_BUILD ON)
DKSET(CURRENT_DIR /usr)
LINUX_COMMAND(sudo apt install libxtst-dev)


### LINK ###
## DKINCLUDE(/usr/include/gtk-2.0)
## DKINCLUDE(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)

SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXtst")