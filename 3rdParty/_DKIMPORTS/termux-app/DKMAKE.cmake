#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ termux-app ############
# https://github.com/termux/termux-app.git
# https://www.macrodroidforum.com/index.php?threads/guide-setting-up-and-using-adb-commands-with-termux.5640/
dk_load(dk_builder)

if(NOT ANDROID_HOST)
	return()
endf()


#dk_import(https://github.com/termux/termux-app.git)
dk_import(https://github.com/termux/termux-app/archive/refs/heads/master.zip)
