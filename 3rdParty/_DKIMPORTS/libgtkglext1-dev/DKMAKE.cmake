include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX_HOST)
	dk_undepend(libgtkglext1-dev)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_command(sudo apt -y install libgtkglext1-dev)
