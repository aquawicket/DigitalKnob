#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Target_Config  "dk_Target_Config()")
if(NOT Linux AND NOT Raspberry)
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
		#dk_exec(tce-load -wi libXinerama-dev.tcz)
		dk_installPackage(libXinerama-dev.tcz)
	else()
		#dk_depend(sudo)
		#dk_exec(${sudo_exe} apt -y install libxinerama-dev)
		dk_installPackage(libxinerama-dev)
	endif()
#endif()

#dynamic linking
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXinerama")
