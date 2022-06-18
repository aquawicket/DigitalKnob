if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
if(LINUX)
	dk_set(CURRENT_DIR /usr)
	DKCOMMAND(sudo apt -y install libglfw3-dev)
endif()
if(MAC)
	DKCOMMAND(brew install glfw3)
	dk_include(/usr/local/include)
	APPLE_DKLIB(/usr/local/lib/libglfw.3.3.dylib)
endif()
