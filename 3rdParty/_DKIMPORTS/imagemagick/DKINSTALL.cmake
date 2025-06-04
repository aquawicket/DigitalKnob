#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ imagemagick ############
# https://github.com/ImageMagick/ImageMagick.git
# https://imagemagick.org/index.php

### DEPEND ###
#dk_depend(ghostscript)

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Windows_Host)
	dk_depend(vc_redist)
endif()

### IMPORT LIBRARY ###
dk_getFileParams("$ENV{DKIMPORTS_DIR}/imagemagick/dkconfig.txt")

if(Android_Host)
	dk_installPackage("${IMAGEMAGICK_ANDROID_IMPORT}")
	execute_process(COMMAND command -v convert OUTPUT_VARIABLE IMAGEMAGICK_CONVERT_EXE)	
elseif(Unix_Host)
	dk_import("${IMAGEMAGICK_UNIX_IMPORT}")
elseif(Windows_X86_Host)
	dk_import("${IMAGEMAGICK_WINDOWS_X86_IMPORT}")
elseif(Windows_X86_64_Host)
	dk_import("${IMAGEMAGICK_WINDOWS_X86_64_IMPORT}")
endif()


### Copy OpenMP library to imagemagic folder
if(Windows_Host)
	if(NOT EXISTS "${IMAGEMAGICK}/vcomp140.dll")
		if(Windows_X86_Host)
			if(EXISTS "${VCCOMP140_X86_DEBUG_DLL}")
				dk_copy("${VCCOMP140_X86_DEBUG_DLL}" "${IMAGEMAGICK}/vcomp140.dll") #rename
			elseif(EXISTS "${VCCOMP140_X86_DLL}")
				dk_copy("${VCCOMP140_X86_DLL}" "${IMAGEMAGICK}/vcomp140.dll")
			endif()
		elseif(Windows_X86_64_Host)
			if(EXISTS "${VCCOMP140_X86_64_DEBUG_DLL}")
				dk_copy("${VCCOMP140_X86_64_DEBUG_DLL}" "${IMAGEMAGICK}/vcomp140.dll") # rename
			elseif(EXISTS "${VCCOMP140_X86_64_DLL}")
				dk_copy("${VCCOMP140_X86_64_DLL}" "${IMAGEMAGICK}/vcomp140.dll")
			endif()
		endif()
		dk_assertPath("${IMAGEMAGICK}/vcomp140.dll")
	endif()
endif()


if(NOT EXISTS "${IMAGEMAGICK_CONVERT_EXE}")
	if(Windows_Host)
		dk_findProgram	(IMAGEMAGICK_CONVERT_EXE magick.exe "${IMAGEMAGICK}")
		dk_assertPath	(IMAGEMAGICK_CONVERT_EXE)
	endif()
endif()

dk_set(IMAGEMAGICK_CONVERT_EXE "${IMAGEMAGICK_CONVERT_EXE}")






### compiling trmporarily disabled ####
return()

if(DKAPP)
if(NOT Android)
if(NOT Windows)
	### LINK ###
	dk_include			(${IMAGEMAGICK_TUPLE_DIR})

	if(Unix)
		dk_libDebug		(${IMAGEMAGICK_DEBUG_DIR}/libimagemagick.a)
		dk_libRelease	(${IMAGEMAGICK_RELEASE_DIR}/libimagemagick.a)
	endif()
	#Windows_dk_libDebug	(${IMAGEMAGICK_DEBUG_DIR}/imagemagickd.lib)
	#Windows_dk_libRelease	(${IMAGEMAGICK_RELEASE_DIR}/imagemagick.lib)


	### GENERATE / COMPILE ###
	dk_configure		(${IMAGEMAGICK_DIR})
	
	dk_build			(${IMAGEMAGICK_DIR})
endif()
endif()
endif()
