### INSTALL ###
dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libxtst-dev)


### LINK ###
## dk_include(/usr/include/gtk-2.0)
## dk_include(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXtst")