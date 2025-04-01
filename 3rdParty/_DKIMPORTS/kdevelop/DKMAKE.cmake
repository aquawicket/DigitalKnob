#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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
