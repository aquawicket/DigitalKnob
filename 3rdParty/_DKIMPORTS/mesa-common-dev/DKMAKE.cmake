include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.mesa3d.org

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(mesa-common-dev)
	dk_return()
endif()


### INSTALL ###
#dk_cd(/usr)
dk_command(${SUDO} apt -y install mesa-common-dev)
