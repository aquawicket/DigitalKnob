#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


########### libglfw3-dev ###########
dk_load(dk_builder)
if(NOT UNIX_HOST)
	dk_undepend(libglfw3-dev)
	dk_return()
endif()

### INSTALL ###
if(LINUX)
	#dk_cd(/usr)
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} apt -y install libglfw3-dev)
	dk_installPackage(libglfw3-dev)
endif()
if(MAC)
	#dk_command(brew install glfw3)
	dk_installPackage(glfw3)
	dk_include(/usr/local/include)
	dk_lib(/usr/local/lib/libglfw.3.3.dylib)
endif()
