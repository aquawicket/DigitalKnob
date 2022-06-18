if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
if(LINUX)
	dk_set(CURRENT_DIR /usr)
	dk_command(sudo apt -y install libglfw3-dev)
endif()
if(MAC)
	dk_command(brew install glfw3)
	dk_include(/usr/local/include)
	APPLE_dk_lib(/usr/local/lib/libglfw.3.3.dylib)
endif()
