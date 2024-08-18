include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# mlocate
# EXAMPLE Usage:   $ locate libx11.a

if(NOT UNIX_HOST OR ANDROID)
	dk_undepend(mlocate)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_command(sudo apt -y install mlocate)
dk_command(sudo updatedb)
