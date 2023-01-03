# https://github.com/ImageMagick/ImageMagick.git
# https://imagemagick.org/index.php


### DEPEND ###
#dk_depend(ghostscript)


### IMPORT ###
WIN_HOST_dk_import	(http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.1.0-57-portable-Q16-x86.zip)
UNIX_HOST_dk_import	(https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-0.zip)
WIN_HOST_dk_set		(IMAGEMAGICK_CONVERT ${IMAGEMAGICK}/convert.exe) # TODO: rename to IMAGEMAGICK_CONVERT_EXE

### LINK ###
dk_include			(${IMAGEMAGICK}/${OS})
#WIN_dk_libDebug	(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/imagemagickd.lib)
#WIN_dk_libRelease	(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/imagemagick.lib)
UNIX_HOST_dk_libDebug	(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/libimagemagick.a)
UNIX_HOST_dk_libRelease	(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/libimagemagick.a)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueShell		(${DKCONFIGURE_BUILD})
DEBUG_dk_queueShell		(make)

RELEASE_dk_setPath		(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueShell	(make)
