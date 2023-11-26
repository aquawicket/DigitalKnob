dk_depend(imagemagick)

dk_generateCmake(DKImageMagick)
dk_assets(DKImageMagick)

IF(WIN_32)
	dk_copy(${IMAGEMAGICK}/magick.exe ${DKPROJECT}/assets/DKImageMagick/magick.exe OVERWRITE)
	##UPX_COMPRESS(${DKPROJECT}/assets/DKImageMagick/magick.exe)
ENDIF()