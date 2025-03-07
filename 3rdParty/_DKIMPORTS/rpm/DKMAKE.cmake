#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://www.thegeekdiary.com/rpm-command-not-found

if(NOT LINUX_HOST OR ANDROID_HOST)
	dk_undepend(rpm)
	dk_return()
endif()

### INSTALL ###
dk_cd(/usr)
#dk_depend(sudo)
#dk_command(${SUDO_EXE} apt -y install rpm)
dk_installPackage(rpm)
