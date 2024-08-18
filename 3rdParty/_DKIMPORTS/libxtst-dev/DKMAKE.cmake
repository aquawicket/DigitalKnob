include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxtst-dev)
	dk_return()
endif()


### INSTALL ###
#dk_set(WORKING_DIRECTORY /usr)
if(TINYCORE)
	dk_command(tce-load -wi libXtst-dev.tcz)
else()
	dk_command(sudo apt -y install libxtst-dev)
endif()

### LINK ###
## dk_include(/usr/include/gtk-2.0)
## dk_include(/usr/lib/x86_64-linux-gnu/gtk-2.0/include)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXtst")
