#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### asio ######
dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/asio/asio.txt ANT_DL)
dk_import		(${ANT_DL})

# TODO
