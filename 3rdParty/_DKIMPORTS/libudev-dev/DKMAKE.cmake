### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libudev-dev)


### LINK ###
#DKINCLUDE(/usr/include/udev)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -ludev")