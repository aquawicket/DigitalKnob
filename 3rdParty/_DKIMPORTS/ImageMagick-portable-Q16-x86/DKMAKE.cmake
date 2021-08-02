if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### DEPENDS ####
DKDEPEND(gs922w64)


### VERSION ###
DKSET(IMAGEMAGICK_VERSION "7.1.0-4")
DKSET(IMAGEMAGICK_NAME ImageMagick-${IMAGEMAGICK_VERSION}-portable-Q16-x86)
DKSET(IMAGEMAGICK_ROOT ${3RDPARTY}/${IMAGEMAGICK_NAME})


### INSTALL ###
## http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.1.0-3-portable-Q16-x86.zip
DKINSTALL(http://ftp.icm.edu.pl/packages/ImageMagick/binaries/${IMAGEMAGICK_NAME}.zip ImageMagick-portable-Q16-x86 ${IMAGEMAGICK})
