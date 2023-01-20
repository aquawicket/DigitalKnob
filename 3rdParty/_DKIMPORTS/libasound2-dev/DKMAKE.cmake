if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libasound2-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libasound2-dev)


### LINK ###
dk_include(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")
