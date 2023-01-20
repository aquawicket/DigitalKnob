# mlocate
# EXAMPLE Usage:   $ locate libx11.a

if(NOT UNIX_HOST OR ANDROID)
	dk_undepend(mlocate)
	dk_return()
endif()

### INSTALL ###
dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install mlocate)
dk_command(sudo updatedb)
