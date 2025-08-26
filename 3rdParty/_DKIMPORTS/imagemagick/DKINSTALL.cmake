#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


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
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

if(Android_Host)
	dk_installPackage("${Imagemagick_Android_Import}")
	execute_process(COMMAND command -v convert OUTPUT_VARIABLE IMAGEMAGICK_CONVERT_EXE)	
elseif(Unix_Host)
	dk_import("${Imagemagick_Unix_Import}")
elseif(Windows_X86_Host)
	dk_import("${Imagemagick_Windows_X86_Import}")
elseif(Windows_X86_64_Host)
	dk_import("${Imagemagick_Windows_X86_64_Import}")
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
	dk_include			(${IMAGEMAGICK_Tuple_Dir})

	if(Unix)
		dk_libDebug		(${IMAGEMAGICK_Debug_Dir}/libimagemagick.a)
		dk_libRelease	(${IMAGEMAGICK_Release_Dir}/libimagemagick.a)
	endif()
	#Windows_dk_libDebug	(${IMAGEMAGICK_Debug_Dir}/imagemagickd.lib)
	#Windows_dk_libRelease	(${IMAGEMAGICK_Release_Dir}/imagemagick.lib)


	### GENERATE / COMPILE ###
	dk_configure		(${IMAGEMAGICK})
	
	dk_build			(${IMAGEMAGICK})
endif()
endif()
endif()
