if(NOT CMAKE_HOST_UNIX)
	return()
endif()

# https://terminator-gtk3.readthedocs.io/en/latest/

### INSTALL ###
if(LINUX)
	DKSET(CURRENT_DIR /usr)
	DKCOMMAND(sudo apt -y install terminator)
endif()
#if(MAC)
#	DKCOMMAND(brew install terminator)
#endif()