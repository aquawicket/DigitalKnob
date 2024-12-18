#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/termux/termux-packages/blob/master/packages/libandroid-spawn/build.sh

#ANDROID_HOST_dk_command(pkg install libandroid-spawn)
dk_installPackage(libandroid-spawn)