if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libsndfile1-dev)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install libsndfile1-dev)


### LINK ###
