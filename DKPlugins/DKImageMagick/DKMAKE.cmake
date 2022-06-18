DKDEPEND(imagemagick)

generateCmake(DKImageMagick)
DKASSETS(DKImageMagick)

IF(WIN_32)
	dk_copy(${IMAGEMAGICK}/magick.exe ${DKPROJECT}/assets/DKImageMagick/magick.exe TRUE)
	##UPX_COMPRESS(${DKPROJECT}/assets/DKImageMagick/magick.exe)
ENDIF()