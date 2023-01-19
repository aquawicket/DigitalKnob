if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxcursor-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libxcursor-dev)

### LINK ###
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXcursor")
