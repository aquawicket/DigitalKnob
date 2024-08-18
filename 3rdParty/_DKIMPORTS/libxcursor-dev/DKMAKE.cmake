include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxcursor-dev)
	dk_return()
endif()

### INSTALL ###
#dk_set(WORKING_DIRECTORY /usr)
if(TINYCORE)
	dk_command(tce-load -wi libXcursor-dev.tcz)
else()
	dk_command(sudo apt -y install libxcursor-dev)
endif()

### LINK ###
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXcursor")
