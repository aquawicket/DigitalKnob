if(NOT CMAKE_HOST_UNIX)
	return()
endif()

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgl1-mesa-dev)
