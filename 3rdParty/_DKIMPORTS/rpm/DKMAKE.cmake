#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.thegeekdiary.com/rpm-command-not-found

if(NOT LINUX_HOST OR ANDROID_HOST)
	dk_undepend(rpm)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
dk_command(${SUDO} apt -y install rpm)
