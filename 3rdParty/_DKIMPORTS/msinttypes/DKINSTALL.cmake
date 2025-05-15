#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
if(NOT Win_Host)
	dk_undepend(msinttypes)
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
