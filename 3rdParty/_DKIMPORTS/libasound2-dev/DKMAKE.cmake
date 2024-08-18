include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libasound2-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(WORKING_DIRECTORY /usr)
dk_command(sudo apt -y install libasound2-dev)

### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi libasound2-dev)
endif()


### LINK ###
dk_include(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")
