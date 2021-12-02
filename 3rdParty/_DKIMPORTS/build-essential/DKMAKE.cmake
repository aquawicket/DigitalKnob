if(NOT CMAKE_HOST_LINUX)
	return()
endif()

DKDEPEND(jdk)

### INSTALL ###
DKSET(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install build-essential)