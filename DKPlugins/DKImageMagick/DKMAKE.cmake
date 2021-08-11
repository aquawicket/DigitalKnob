DKDEPEND(ImageMagick)

DKPLUGIN(DKImageMagick)
DKASSETS(DKImageMagick)

IF(WIN_32)
	DKCOPY(${IMAGEMAGICK}/magick.exe ${DKPROJECT}/assets/DKImageMagick/magick.exe TRUE)
	##UPX_COMPRESS(${DKPROJECT}/assets/DKImageMagick/magick.exe)
ENDIF()