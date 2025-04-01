#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### libglfw3-dev ###########
dk_load(dk_builder)
if(NOT UNIX_HOST)
	dk_undepend(libglfw3-dev)
	dk_return()
endif()

### INSTALL ###
if(LINUX)
	dk_installPackage(libglfw3-dev)
endif()
if(MAC)
	#dk_command(brew install glfw3)
	dk_installPackage(glfw3)
	dk_include(/usr/local/include)
	dk_lib(/usr/local/lib/libglfw.3.3.dylib)
endif()
