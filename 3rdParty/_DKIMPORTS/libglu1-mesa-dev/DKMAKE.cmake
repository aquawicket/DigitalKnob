include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libglu1-mesa-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_command(sudo apt -y install libglu1-mesa-dev)
