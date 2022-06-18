if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libsndfile1-dev)


### LINK ###
