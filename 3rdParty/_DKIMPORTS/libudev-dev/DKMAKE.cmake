if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libudev-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libudev-dev)


### LINK ###
#dk_include(/usr/include/udev)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -ludev")
