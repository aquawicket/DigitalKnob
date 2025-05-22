#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKImageMagick ############
dk_depend(imagemagick)

dk_generateCmake(DKImageMagick)
dk_assets(DKImageMagick)

if(Windows_X86)
	dk_copy(${IMAGEMAGICK}/magick.exe ${Target_App_Dir}/assets/DKImageMagick/magick.exe OVERWRITE)
	##UPX_COMPRESS(${Target_App_Dir}/assets/DKImageMagick/magick.exe)
endif()