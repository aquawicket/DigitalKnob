#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ termux-app ############
# https://github.com/termux/termux-app.git
# https://www.macrodroidforum.com/index.php?threads/guide-setting-up-and-using-adb-commands-with-termux.5640/
dk_load(dk_builder)

if(NOT ANDROID_HOST)
	return()
endif()


#dk_import(https://github.com/termux/termux-app.git)
dk_import(https://github.com/termux/termux-app/archive/refs/heads/master.zip)
