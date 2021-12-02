if(NOT CMAKE_HOST_UNIX)
	return()
endif()

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install build_essential)