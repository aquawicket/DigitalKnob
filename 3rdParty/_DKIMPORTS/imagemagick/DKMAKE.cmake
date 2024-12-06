#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ "${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/")
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ imagemagick ############
# https://github.com/ImageMagick/ImageMagick.git
# https://imagemagick.org/index.php

### DEPEND ###
#dk_depend(ghostscript)

dk_validate(host_triple "dk_host_triple()")
#if(WIN_HOST)
#	dk_depend(vc_redist)
#endif()

### IMPORT LIBRARY ###
if(UNIX_HOST)
	dk_import("https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-0.zip")
elseif(WIN_X86_HOST)
	dk_import("https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-41-portable-Q16-x86.zip")
elseif(WIN_X86_64_HOST)
	dk_import("https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-41-portable-Q16-x86.zip")
endif()

if(NOT EXISTS "${IMAGEMAGICK_CONVERT_EXE}")
	if(WIN_HOST)
		dk_findProgram	(IMAGEMAGICK_CONVERT_EXE magick.exe "${IMAGEMAGICK}")
		dk_assertPath	(IMAGEMAGICK_CONVERT_EXE)
	endif()
endif()


if(DKAPP)
if(NOT ANDROID)
if(NOT WIN)
	### LINK ###
	dk_include			(${IMAGEMAGICK_TRIPLE_DIR})

	if(UNIX)
		dk_libDebug		(${IMAGEMAGICK_DEBUG_DIR}/libimagemagick.a)
		dk_libRelease	(${IMAGEMAGICK_RELEASE_DIR}/libimagemagick.a)
	endif()
	#WIN_dk_libDebug	(${IMAGEMAGICK_DEBUG_DIR}/imagemagickd.lib)
	#WIN_dk_libRelease	(${IMAGEMAGICK_RELEASE_DIR}/imagemagick.lib)


	### GENERATE / COMPILE ###
	dk_configure		(${IMAGEMAGICK_DIR})
	
	dk_build			(${IMAGEMAGICK_DIR})
endif()
endif()
endif()
