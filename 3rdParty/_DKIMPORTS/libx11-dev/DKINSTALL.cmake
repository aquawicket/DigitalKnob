#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libx11-dev ############
#

dk_load(dk_builder)
if(NOT Linux AND NOT Raspberry)
	dk_undepend(libx11-dev)
	dk_return()
endif()

### INSTALL ###
if(Mac)
	dk_include(/opt/X11/include)
endif()

if(Linux OR Raspberry)
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
	
	###### DYNAMIC LINKING ######
	#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lX11")
	#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXinerama")  # used by openscenegraph, moved to libxinerama-dev
	
	###### STATIC LINKING ######	
	if(Linux_X86_64)
		dk_lib(/usr/lib/x86_64-linux-gnu/libX11.a)
		dk_lib(/usr/lib/x86_64-linux-gnu/libxcb.a)
		dk_lib(/usr/lib/x86_64-linux-gnu/libXau.a)
		dk_lib(/usr/lib/x86_64-linux-gnu/libXtst.a)
		dk_lib(/usr/lib/x86_64-linux-gnu/libXdmcp.a)
		dk_lib(/usr/lib/x86_64-linux-gnu/libXext.a)
	endif()
	if(Raspberry)
		dk_lib(/usr/lib/arm-linux-gnueabihf/libX11.a)
		dk_lib(/usr/lib/arm-linux-gnueabihf/libxcb.a)
		dk_lib(/usr/lib/arm-linux-gnueabihf/libXau.a)
		dk_lib(/usr/lib/arm-linux-gnueabihf/libXtst.a)
	endif()
endif()
