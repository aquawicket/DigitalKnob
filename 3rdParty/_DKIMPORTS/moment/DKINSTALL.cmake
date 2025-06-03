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


############ moment ############
# https://github.com/moment/moment
# https://momentjs.com/

dk_validate(Config_Path  "dk_Config_Path()")

dk_import(https://github.com/moment/moment/raw/e9680920/moment.js)

#dk_set(MOMENTJS_VERSION 2.29.1)
#dk_set(MOMENTJS_FOLDER moment.js-${MOMENTJS_VERSION})
#dk_set(MOMENTJS_DL https://github.com/moment/moment/raw/2.29.1/moment.js)
#dk_set(MOMENTJS_DL https://momentjs.com/downloads/moment.min.js
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(MOMENTJS $ENV{DK3RDPARTY_DIR}/${MOMENTJS_FOLDER})
#dk_import(${MOMENTJS_DL} ${MOMENTJS})
