#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libx11-dev)
	dk_return()
endif()

### INSTALL ###
if(MAC)
	dk_include(/opt/X11/include)
endif()

if(LINUX OR RASPBERRY)
	if(EXISTS /usr/include/X11)
		### LINK ###
		dk_include(/usr/include/X11)
	elseif(EXISTS /usr/local/include/X11)
		### LINK ###
		dk_include(/usr/local/include/X11)
	else()
		### INSTALL ###
		if(TINYCORE)
			#dk_command(tce-load -wi libX11-dev.tcz)
			dk_installPackage(libX11-dev.tcz)
		else()
			dk_installPackage(libx11-dev)
		endif()
	endif()
	
	#dynamic linking
	SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lX11")
	#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXinerama")  # used by openscenegraph, moved to libxinerama-dev
	
	#static linking
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libX11.a)
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libxcb.a)
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libXau.a)
endif()
