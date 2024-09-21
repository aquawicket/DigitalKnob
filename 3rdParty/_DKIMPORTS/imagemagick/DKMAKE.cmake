include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/ImageMagick/ImageMagick.git
# https://imagemagick.org/index.php

### DEPEND ###
#dk_depend(ghostscript)

dk_validate(HOST_TRIPLE "dk_HOST_TRIPLE()")
if(WIN_HOST)
	#dk_load	(${DKIMPORTS_DIR}/vc_redist/DKMAKE.cmake)
	dk_depend	(vc_redist)
endif()


### IMPORT LIBRARY ###
UNIX_HOST_dk_import			(https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-0.zip)

### IMPORT BINARY ###
WIN_X86_HOST_dk_import		(https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-38-portable-Q16-x86.zip)
WIN_X86_64_HOST_dk_import	(https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-38-portable-Q16-x64.zip)
WIN_HOST_dk_set				(IMAGEMAGICK_CONVERT_EXE ${IMAGEMAGICK_DIR}/magick.exe)



if(DKAPP)
if(NOT ANDROID)
if(NOT WIN)
	### LINK ###
	dk_include				(${IMAGEMAGICK_TRIPLE_DIR})

	UNIX_dk_libDebug		(${IMAGEMAGICK_DEBUG_DIR}/libimagemagick.a)
	UNIX_dk_libRelease		(${IMAGEMAGICK_RELEASE_DIR}/libimagemagick.a)
	#WIN_dk_libDebug		(${IMAGEMAGICK_DEBUG_DIR}/imagemagickd.lib)
	#WIN_dk_libRelease		(${IMAGEMAGICK_RELEASE_DIR}/imagemagick.lib)


	### GENERATE / COMPILE ###
	dk_configure			(${IMAGEMAGICK_DIR})
	
	dk_build				(${IMAGEMAGICK_DIR})
endif()
endif()
endif()
