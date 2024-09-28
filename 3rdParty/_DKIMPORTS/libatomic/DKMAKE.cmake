#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libatomic)
	dk_return()
endif()

### INSTALL ###
if(LINUX OR RASPBERRY)
	#dk_cd(/usr)
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} apt -y install libatomic)

	### LINK ###
	#dk_include(/usr/include/atomic)
	
	#dynamic linking
	set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -latomic")
	
	#static linking
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libatomic.a)
endif()
