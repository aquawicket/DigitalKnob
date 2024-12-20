#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ moment ############
# https://github.com/moment/moment
# https://momentjs.com/

dk_load(dk_builder)

dk_import(https://github.com/moment/moment/raw/e9680920/moment.js)

#dk_set(MOMENTJS_VERSION 2.29.1)
#dk_set(MOMENTJS_FOLDER moment.js-${MOMENTJS_VERSION})
#dk_set(MOMENTJS_DL https://github.com/moment/moment/raw/2.29.1/moment.js)
#dk_set(MOMENTJS_DL https://momentjs.com/downloads/moment.min.js
#dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
#dk_set(MOMENTJS ${DK3RDPARTY_DIR}/${MOMENTJS_FOLDER})
#dk_import(${MOMENTJS_DL} ${MOMENTJS})
