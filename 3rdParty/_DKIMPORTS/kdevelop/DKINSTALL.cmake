#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ kdevelop ############
# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/
dk_validate(Target_Config  "dk_Target_Config()")
if(NOT Linux_Host)
	dk_disable(kdevelop)
	dk_return()
endif()

### IMPORT ###
dk_import(https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage)

### INSTALL ###
dk_exec(chmod 777 ${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
dk_exec(${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
