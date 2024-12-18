#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxfixes-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	#dk_command(tce-load -wi libXfixes-dev.tcz)
	dk_installPackage(libXfixes-dev.tcz)
else()
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} apt -y install libxfixes-dev)
	dk_installPackage(libxfixes-dev)
endif()
