### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt install libasound2-dev)


### LINK ###
DKINCLUDE(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")