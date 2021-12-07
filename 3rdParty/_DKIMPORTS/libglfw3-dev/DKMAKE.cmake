if(NOT CMAKE_HOST_UNIX)
	return()
endif()

### INSTALL ###
if(LINUX)
	DKSET(CURRENT_DIR /usr)
	DKCOMMAND(sudo apt -y install libglfw3-dev)
endif()
if(MAC)
	DKCOMMAND(brew install glfw3)
	DKINCLUDE(/usr/local/include)
	APPLE_LIB(/usr/local/lib/libglfw.3.3.dylib)
endif()
