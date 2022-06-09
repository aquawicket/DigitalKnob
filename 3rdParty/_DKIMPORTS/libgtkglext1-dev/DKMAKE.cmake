if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install libgtkglext1-dev)

