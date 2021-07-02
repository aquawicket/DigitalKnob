if(NOT LINUX AND NOT RASPBERRY)
	return()
endif()


### INSTALL ###
DKSET(QUEUE_BUILD ON)
DKSET(CURRENT_DIR /usr)
LINUX_COMMAND(sudo apt install libgl1-mesa-dev)