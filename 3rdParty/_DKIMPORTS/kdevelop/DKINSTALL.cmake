#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ kdevelop ############
# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/
# https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage

if(NOT Linux_Host)
	dk_disable(kdevelop)
	dk_return()
endif()

dk_import()

dk_exec(chmod 777 ${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
dk_exec(${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
