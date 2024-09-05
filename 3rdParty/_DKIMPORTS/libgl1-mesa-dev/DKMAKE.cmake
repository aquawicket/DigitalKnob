include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libgl1-mesa-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_command(${SUDO} apt -y install libgl1-mesa-dev)
