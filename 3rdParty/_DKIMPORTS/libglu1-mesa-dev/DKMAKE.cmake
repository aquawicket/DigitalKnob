if(NOT LINUX AND NOT RASPBERRY OR TINYCORE)
	dk_undepend(libglu1-mesa-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libglu1-mesa-dev)
