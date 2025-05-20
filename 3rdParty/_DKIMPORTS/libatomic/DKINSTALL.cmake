#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libatomic ############
dk_load(dk_builder)
if(NOT Linux AND NOT Raspberry)
	dk_undepend(libatomic)
	dk_return()
endif()

### INSTALL ###
if(Linux OR Raspberry)
	#dk_installPackage(libatomic)

	### LINK ###
	#dk_include(/usr/include/atomic)
	
	#dynamic linking
	set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -latomic")
	
	#static linking
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libatomic.a)
endif()
