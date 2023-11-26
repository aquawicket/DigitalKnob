if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libatomic)
	dk_return()
endif()

### INSTALL ###
if(LINUX OR RASPBERRY)
	#dk_set(CURRENT_DIR /usr)
	#dk_command(sudo apt -y install libatomic)

	### LINK ###
	#dk_include(/usr/include/atomic)
	
	#dynamic linking
	set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -latomic")
	
	#static linking
	#RASPBERRY_dk_lib(/usr/lib/arm-linux-gnueabihf/libatomic.a)
endif()
