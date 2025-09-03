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


############ giflib ############
# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz
# https://stackoverflow.com/a/34102586/688352  #'aclocal-1.15' is missing on your system

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
if(Windows)
	dk_validate(msys2 "dk_depend(msys2)")
endif()
dk_depend(autotools)
#dk_depend(gcc)

### IMPORT ###
#dk_import(${giflib_Import} PATCH)
dk_import()

set(GIFLIB_USE_CMAKE ON)
if(GIFLIB_USE_CMAKE)

	### LINK ###
	dk_include			(${GIFLIB}								GIF_INCLUDE_DIR)
	#dk_include			(${GIFLIB}/lib							GIF_INCLUDE_DIR)
	dk_include			(${GIFLIB_Config_Dir}					GIF_INCLUDE_DIR2)
	if(Windows AND MSVC)
		dk_libDebug		(${GIFLIB_Debug_Dir}/giflibd.lib		GIF_LIBRARY_DEBUG)
		dk_libRelease	(${GIFLIB_Release_Dir}/giflib.lib		GIF_LIBRARY_RELEASE)
	else()
		dk_libDebug		(${GIFLIB_Debug_Dir}/libgiflib.a		GIF_LIBRARY_DEBUG)
		dk_libRelease	(${GIFLIB_Release_Dir}/libgiflib.a		GIF_LIBRARY_RELEASE)
	endif()
	
	### 3RDPARTY LINK ###
	dk_append			(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2})
	if(Debug)
		dk_append		(GIFLIB_CMAKE -DGIF_LIBRARY=${GIF_LIBRARY_DEBUG})
	endif()
	if(Release)
		dk_append		(GIFLIB_CMAKE -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})
	endif()
	dk_configure		(${GIFLIB})
	dk_build			(${GIFLIB} giflib)	
	
	
else()
	### LINK ###
	dk_include			(${GIFLIB}/lib								GIF_INCLUDE_DIR)
	#dk_include			(${GIFLIB}/${Target_Tuple}					GIF_INCLUDE_DIR2)
	dk_include			(${GIFLIB_Config_Dir}						GIF_INCLUDE_DIR2)
	dk_libDebug			(${GIFLIB_Debug_Dir}/lib/.libs/libgif.a		GIF_LIBRARY_DEBUG)
	dk_libRelease		(${GIFLIB_Release_Dir}/lib/.libs/libgif.a	GIF_LIBRARY_RELEASE)

	### 3RDPARTY LINK ###
	if(Debug)
		dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_DEBUG})
	endif()
	if(Release)
		dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})
	endif()
	
	### GENERATE / CONFIGURE ###
	dk_chdir	(${GIFLIB})
	dk_depend	(bash)
	dk_exec		(${bash_exe} -c "autoreconf -f -i")

	string(REPLACE "-std=c17" "" GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
	string(REPLACE "-std=c++1z" "" GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
	string(REPLACE "  " " " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")

	dk_configure			(${GIFLIB})
	if(Android)
		if(MSVC)
			dk_visualStudio	(${GIFLIB} giflib)
		else()
			dk_exec			(make -C lib)
		endif()
	else()
		if(Emscripten)
			dk_build		(${GIFLIB})
		else()
			dk_exec			(make -C lib)
		endif()
	endif()
endif()

# FIX for other searchers
#dk_copy(${GIFLIB}/gif_lib.h ${GIFLIB}/lib/gif_lib.h)
