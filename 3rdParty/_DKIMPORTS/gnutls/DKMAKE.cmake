#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)


### INSTALL ###
if(LINUX)
	dk_cd(/usr)
	dk_depend(sudo)
	dk_command(${SUDO_EXE} apt -y install libgnutls)
endif()
if(MAC)
	dk_command(brew install gnutls)
	dk_include(/usr/local/include)
	dk_lib(/usr/local/lib/libgnutls.dylib)
endif()