# https://www.mesa3d.org

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(mesa-common-dev)
	dk_return()
endif()


### INSTALL ###
#dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install mesa-common-dev)
