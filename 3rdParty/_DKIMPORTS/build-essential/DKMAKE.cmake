if(NOT LINUX_HOST)
	return()
endif()

DKDEPEND(jdk)

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install build-essential)