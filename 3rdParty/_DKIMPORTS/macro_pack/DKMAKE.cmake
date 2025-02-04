#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ macro_pack ############

# https://github.com/sevagas/macro_pack.git
# https://blog.sevagas.com/?Advanced-USB-key-phishing&lang=en