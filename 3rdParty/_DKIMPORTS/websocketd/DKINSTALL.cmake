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


###### websocketd ######
# https://github.com/joewalnes/websocketd/archive/8d6da30045855d1d9d81fd8a0936ef84981764f0.zip

### INSTALL ###
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

#dk_validate(Host_Tuple "dk_Host_Tuple()")
#dk_import(${websocketd_${Host_Tuple}_Import})
dk_import()