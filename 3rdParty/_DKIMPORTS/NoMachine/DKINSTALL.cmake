#/usr/bin/cmake -P
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


###### NoMachine ######
dk_import(APP)

dk_set(nxplayer_exe "${NoMachine}/bin/nxplayer.exe")
if(EXISTS "${nxplayer_exe}")
	return()
endif()


file(TO_NATIVE_PATH "${NoMachine_Install_Path}" NoMachine_Install_Path)
dk_exec("${NoMachine_Download_Path}" /SILENT "/DIR=${NoMachine_Install_Path}")
