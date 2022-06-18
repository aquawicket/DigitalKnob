# mlocate
# EXAMPLE Usage:   $ locate libx11.a

if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install mlocate)
DKCOMMAND(sudo updatedb)
