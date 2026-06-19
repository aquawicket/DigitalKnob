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


###### android-system-images ######
# https://androidsdkoffline.blogspot.com/p/android-sysimg-arm-v7a-direct-download.html
# https://androidsdkoffline.blogspot.com/p/android-sysimg-arm-v8a-direct-download.html

dk_validate(android-sdk "dk_depend(android-sdk)")
dk_mkdir(${android-sdk}/system-images)

dk_import(${ANDROID_SYSTEM_IMAGES_DL} _PATH_ ${android-sdk}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION})
