dk_depend(imagemagick)

dk_generateCmake(DKImageMagick)
dk_assets(DKImageMagick)

if(WIN_X86)
	dk_copy(${IMAGEMAGICK}/magick.exe ${DK_PROJECT_DIR}/assets/DKImageMagick/magick.exe OVERWRITE)
	##UPX_COMPRESS(${DK_PROJECT_DIR}/assets/DKImageMagick/magick.exe)
endif()