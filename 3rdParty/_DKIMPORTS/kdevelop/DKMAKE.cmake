#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/

if(NOT LINUX_HOST)
	dk_return()
endif()


### IMPORT ###
LINUX_dk_import(https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage)


### INSTALL ###
LINUX_dk_queueCommand(chmod 777 ${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
LINUX_dk_queueCommand(${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
