#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://packages.ubuntu.com/focal/build-essential

#if(NOT LINUX_HOST)
#	dk_undepend(build-essential)
#	dk_return()
#endif()
if(WIN_HOST)
	dk_undepend(build-essential)
	dk_return()
endif()

#dk_depend(openjdk)
dk_depend(sudo)

if(ANDROID_HOST)
	dk_command(pkg install build-essential)
elseif(NOT ANDROID)
	dk_cd(/usr)
	dk_command(${SUDO} apt -y install build-essential)
endif()

#dk_todo("tiny-core-lunux build-essential")
