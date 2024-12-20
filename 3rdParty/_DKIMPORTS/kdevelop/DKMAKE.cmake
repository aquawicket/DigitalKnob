#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ kdevelop ############
# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/
dk_load(dk_builder)
if(NOT LINUX_HOST)
	dk_undepend(kdevelop)
	dk_return()
endif()

### IMPORT ###
dk_import(https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage)

### INSTALL ###
dk_queueCommand(chmod 777 ${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
dk_queueCommand(${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
