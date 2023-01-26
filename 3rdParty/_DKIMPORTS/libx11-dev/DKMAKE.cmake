if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libx11-dev)
	dk_return()
endif()

### INSTALL ###
if(MAC)
	dk_include(/opt/X11/include)
endif()

if(LINUX OR RASPBERRY)
	#dk_set(CURRENT_DIR /usr)
	
	if(EXISTS /usr/include/X11)
		### LINK ###
		dk_include(/usr/include/X11)
	elseif(EXISTS /usr/local/include/X11)
		### LINK ###
		dk_include(/usr/local/include/X11)
	else()
		### INSTALL ###
		dk_command(sudo apt -y install libx11-dev)
	endif()
	
	#dynamic linking
	SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lX11")
	SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXinerama")  # used by openscenegraph
	
	#static linking
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libX11.a)
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libxcb.a)
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libXau.a)
endif()
