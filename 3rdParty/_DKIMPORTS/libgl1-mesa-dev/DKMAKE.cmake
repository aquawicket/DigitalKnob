if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libgl1-mesa-dev)
