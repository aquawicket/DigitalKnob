# http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.1.0-4-portable-Q16-x86.zip

### DEPENDS ####
DKDEPEND(ghostscript)


### VERSION ###
DKSET(IMAGEMAGICK_VERSION "7.1.0-4")
DKSET(IMAGEMAGICK_NAME ImageMagick-${IMAGEMAGICK_VERSION}-portable-Q16-x86)
DKSET(IMAGEMAGICK_DL http://ftp.icm.edu.pl/packages/ImageMagick/binaries/${IMAGEMAGICK_NAME}.zip)
DKSET(IMAGEMAGICK ${3RDPARTY}/${IMAGEMAGICK_NAME})


### INSTALL ###
DKINSTALL(${IMAGEMAGICK_DL} ImageMagick-portable-Q16-x86 ${IMAGEMAGICK})
