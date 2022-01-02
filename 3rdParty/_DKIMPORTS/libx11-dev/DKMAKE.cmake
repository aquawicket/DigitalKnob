if(NOT UNIX_HOST)
	return()
endif()

### INSTALL ###
if(MAC)
	DKINCLUDE(/opt/X11/include)
endif()


if(LINUX OR RASPBERRY)
	DKSET(CURRENT_DIR /usr)
	DKCOMMAND(sudo apt -y install libx11-dev)

	### LINK ###
	DKINCLUDE(/usr/include/X11)
	
	#dynamic linking
	SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lX11")
	
	#static linking
	#RASPBERRY_DKLIB(/usr/lib/arm-linux-gnueabihf/libX11.a)
	#RASPBERRY_DKLIB(/usr/lib/arm-linux-gnueabihf/libxcb.a)
	#RASPBERRY_DKLIB(/usr/lib/arm-linux-gnueabihf/libXau.a)
endif()