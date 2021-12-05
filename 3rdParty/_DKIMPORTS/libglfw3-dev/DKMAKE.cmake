if(NOT CMAKE_HOST_UNIX)
	return()
endif()

### INSTALL ###
if(LINUX)
	DKSET(CURRENT_DIR /usr)
	DKCOMMAND(sudo apt -y install libglfw3-dev)
endif()
if(MAC)
	DKCOMMAND(glfw3)
endif()
