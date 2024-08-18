include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libsndfile1-dev)
	dk_return()
endif()

### INSTALL ###
#dk_cd(/usr)
if(TINYCORE)
	dk_command(tce-load -wi libsndfile-dev.tcz)
else()
	dk_command(sudo apt -y install libsndfile1-dev)
endif()


### LINK ###
