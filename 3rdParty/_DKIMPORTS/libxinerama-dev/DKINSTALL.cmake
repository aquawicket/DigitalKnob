#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxinerama-dev)
	dk_return()
endif()


#if(EXISTS /usr/include/X11)
#	### LINK ###
#	dk_include(/usr/include/X11)
#elseif(EXISTS /usr/local/include/X11)
#	### LINK ###
#	dk_include(/usr/local/include/X11)
#else()


	### INSTALL ###
	if(TINYCORE)
		#dk_command(tce-load -wi libXinerama-dev.tcz)
		dk_installPackage(libXinerama-dev.tcz)
	else()
		#dk_depend(sudo)
		#dk_command(${SUDO_EXE} apt -y install libxinerama-dev)
		dk_installPackage(libxinerama-dev)
	endif()
#endif()

#dynamic linking
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXinerama")
