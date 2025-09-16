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
if(NOT Windows_Host)
	dk_disable(msinttypes)
	dk_return()
endif()
## https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip

### VERSION ###
#dk_set(MSINTTYPES_VERSION r26)
#dk_set(MSINTTYPES_FOLDER msinttypes-${MSINTTYPES_VERSION})
#dk_set(MSINTTYPES_DL https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip)
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(MSINTTYPES $ENV{DK3RDPARTY_DIR}/${MSINTTYPES_FOLDER})


### INSTALL ###
dk_import(https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip)


### 3RDPARTY LINK ###
dk_set(MSINTTYPES_CMAKE "-DCMAKE_C_FLAGS=/I${MSINTTYPES}" "-DCMAKE_CXX_FLAGS=/I${MSINTTYPES}")
