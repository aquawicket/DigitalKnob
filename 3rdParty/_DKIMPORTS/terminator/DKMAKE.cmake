#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://terminator-gtk3.readthedocs.io/en/latest/


#LINUX_HOST_dk_cd(/usr)
dk_depend(sudo)
#LINUX_HOST_dk_command(${SUDO_EXE} apt -y install terminator) #FIXME sudo needed
#MAC_HOST_dk_command(brew install terminator)
dk_installPackage(terminator)
