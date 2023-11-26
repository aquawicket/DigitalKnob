if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libgl1-mesa-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libgl1-mesa-dev)
