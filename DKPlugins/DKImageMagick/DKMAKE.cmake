#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKImageMagick ############
dk_depend(imagemagick)

dk_generateCmake(DKImageMagick)
dk_assets(DKImageMagick)

if(WIN_X86)
	dk_copy(${IMAGEMAGICK}/magick.exe ${DK_PROJECT_DIR}/assets/DKImageMagick/magick.exe OVERWRITE)
	##UPX_COMPRESS(${DK_PROJECT_DIR}/assets/DKImageMagick/magick.exe)
endif()