if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxfixes-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	dk_command(tce-load -wi libXfixes-dev.tcz)
else()
	dk_command(sudo apt -y install libxfixes-dev)
endif()
