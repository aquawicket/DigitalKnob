#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://packages.ubuntu.com/focal/build-essential


dk_load(dk_builder)
#if(NOT LINUX_HOST)
#	dk_undepend(build-essential)
#	dk_return()
#endif()
if(WIN_HOST)
	dk_undepend(build-essential)
	dk_return()
endif()

#dk_depend(openjdk)



if(ANDROID_HOST)
	#dk_command(pkg install build-essential)
elseif(NOT ANDROID)
	#dk_cd(/usr)
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} apt -y install build-essential)
endif()
dk_installPackage(build-essential)


#dk_todo("tiny-core-linux build-essential")
