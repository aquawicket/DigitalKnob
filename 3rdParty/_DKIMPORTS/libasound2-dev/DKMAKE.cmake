if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libasound2-dev)


### LINK ###
DKINCLUDE(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")