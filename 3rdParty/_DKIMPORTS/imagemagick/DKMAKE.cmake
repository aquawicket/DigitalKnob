include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/ImageMagick/ImageMagick.git
# https://imagemagick.org/index.php

### DEPEND ###
#dk_depend(ghostscript)
dk_depend(vc_redist)

dk_validate(HOST "dk_getHostTriple()")
if(WIN_HOST)
	dk_load(${DKIMPORTS_DIR}/vc_redist/DKMAKE.cmake)
	dk_assert(VCCOMP140_DLL)
endif()


### IMPORT LIBRARY ###
UNIX_HOST_dk_import			(https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-0.zip)

### IMPORT BINARY ###
WIN_X86_HOST_dk_import		(https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-34-portable-Q16-x86.zip)
WIN_X86_64_HOST_dk_import	(https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-34-portable-Q16-x64.zip)
WIN_HOST_dk_set				(IMAGEMAGICK_CONVERT_EXE ${IMAGEMAGICK}/magick.exe)



if(DKAPP)
if(NOT ANDROID)
if(NOT WIN)
	### LINK ###
	dk_include				(${IMAGEMAGICK}/${OS})

	UNIX_HOST_dk_libDebug	(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/libimagemagick.a)
	UNIX_HOST_dk_libRelease	(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/libimagemagick.a)
	#WIN_dk_libDebug		(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/imagemagickd.lib)
	#WIN_dk_libRelease		(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/imagemagick.lib)


	### GENERATE / COMPILE ###
	#DEBUG_dk_setPath		(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
	#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
	#RELEASE_dk_setPath		(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
	#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
	dk_configure			(${IMAGEMAGICK})
	
	dk_build				(${IMAGEMAGICK})
endif()
endif()
endif()
