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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKImageMagick ############
dk_depend(imagemagick)



############ DKImageMagick ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()

if(Windows_X86)
	dk_copy(${imagemagick}/magick.exe ${Target_App_Dir}/assets/DKImageMagick/magick.exe OVERWRITE)
	# UPX_COMPRESS(${Target_App_Dir}/assets/DKImageMagick/magick.exe)
endif()