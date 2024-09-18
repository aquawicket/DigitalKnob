include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libxrandr-dev)
	dk_return()
endif()

### INSTALL ###
#dk_cd(/usr)

if(TINYCORE)
	dk_command(tce-load -wi libXrandr-dev.tcz)
else()
	dk_command(${SUDO} apt -y install libxrandr-dev)
endif()

### LINK ###
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lXrandr")
