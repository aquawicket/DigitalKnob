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
	dk_installPackage("${imagemagick_Android_Import}")
	execute_process(COMMAND command -v convert OUTPUT_VARIABLE magick_exe)	
elseif(Unix_Host)
	dk_import("${imagemagick_Unix_Import}")
elseif(Windows_X86_Host)
	dk_import("${imagemagick_Windows_X86_Import}")
elseif(Windows_X86_64_Host)
	dk_import("${imagemagick_Windows_X86_64_Import}")
endif()


### Copy OpenMP library to imagemagic folder
if(Windows_Host)
	if(NOT EXISTS "${imagemagick}/vcomp140.dll")
		if(Windows_X86_Host)
			if(EXISTS "${vcomp140d_X86_dll}")
				dk_copy("${vcomp140d_X86_dll}" "${imagemagick}/vcomp140.dll") #rename
			elseif(EXISTS "${vcomp140_X86_dll}")
				dk_copy("${vcomp140_X86_dll}" "${imagemagick}/vcomp140.dll")
			endif()
		elseif(Windows_X86_64_Host)
			if(EXISTS "${vccomp140d_x86_64_dll}")
				dk_copy("${vccomp140d_x86_64_dll}" "${imagemagick}/vcomp140.dll") # rename
			elseif(EXISTS "${vccomp140_x86_64_dll}")
				dk_copy("${vccomp140_x86_64_dll}" "${imagemagick}/vcomp140.dll")
			endif()
		endif()
		dk_assertPath("${imagemagick}/vcomp140.dll")
	endif()
endif()


if(NOT EXISTS "${magick_exe}")
	if(Windows_Host)
		dk_findProgram	(magick_exe magick.exe "${imagemagick}")
		dk_assertPath	(magick_exe)
	endif()
endif()

dk_set(magick_exe "${magick_exe}")






### compiling trmporarily disabled ####
return()

if(DKAPP)
if(NOT Android)
if(NOT Windows)
	### LINK ###
	dk_include			(${imagemagick_Tuple_Dir})

	if(Unix)
		dk_libDebug		(${imagemagick_Debug_Dir}/libimagemagick.a)
		dk_libRelease	(${imagemagick_Release_Dir}/libimagemagick.a)
	endif()
	#Windows_dk_libDebug	(${imagemagick_Debug_Dir}/imagemagickd.lib)
	#Windows_dk_libRelease	(${imagemagick_Release_Dir}/imagemagick.lib)


	### GENERATE / COMPILE ###
	dk_configure		(${imagemagick})
	
	dk_build			(${imagemagick})
endif()
endif()
endif()
