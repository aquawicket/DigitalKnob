include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)

dk_depend(sudo)

### INSTALL ###
if(LINUX)
	dk_cd(/usr)
	dk_command(${SUDO} apt -y install libgnutls)
endif()
if(MAC)
	dk_command(brew install gnutls)
	dk_include(/usr/local/include)
	dk_lib(/usr/local/lib/libgnutls.dylib)
endif()