if(NOT LINUX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libgtkglext1-dev)

