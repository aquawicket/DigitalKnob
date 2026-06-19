#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ giflib ############
# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz
# https://stackoverflow.com/a/34102586/688352  #'aclocal-1.15' is missing on your system
# https://github.com/nesbox/giflib/archive/1aa11b06.zip

if(Windows)
	dk_validate(msys2 "dk_depend(msys2)")
endif()
dk_depend(autotools)
#dk_depend(gcc)

dk_import() #PATCH

set(giflib_USE_CMAKE ON)
if(giflib_USE_CMAKE)

	dk_include			(${giflib}								GIF_INCLUDE_DIR)
	#dk_include			(${giflib}/lib							GIF_INCLUDE_DIR)
	dk_include			(${giflib_Config_Dir}					GIF_INCLUDE_DIR2)
	if(Windows AND MSVC)
		dk_libDebug		(${giflib_Debug_Dir}/giflibd.lib		GIF_LIBRARY_DEBUG		GIF_LIBRARY)
		dk_libRelease	(${giflib_Release_Dir}/giflib.lib		GIF_LIBRARY_RELEASE		GIF_LIBRARY)
	else()
		dk_libDebug		(${giflib_Debug_Dir}/libgiflib.a		GIF_LIBRARY_DEBUG		GIF_LIBRARY)
		dk_libRelease	(${giflib_Release_Dir}/libgiflib.a		GIF_LIBRARY_RELEASE		GIF_LIBRARY)
	endif()
	
	### 3RDPARTY LINK ###
	dk_set				(giflib_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY})
	dk_configure		(${giflib})
	dk_build			(${giflib} giflib)	
	
	
else()
	dk_include			(${giflib}/lib								GIF_INCLUDE_DIR)
	#dk_include			(${giflib}/${Target_Tuple}					GIF_INCLUDE_DIR2)
	dk_include			(${giflib_Config_Dir}						GIF_INCLUDE_DIR2)
	dk_libDebug			(${giflib_Debug_Dir}/lib/.libs/libgif.a		GIF_LIBRARY_DEBUG		GIF_LIBRARY)
	dk_libRelease		(${giflib_Release_Dir}/lib/.libs/libgif.a	GIF_LIBRARY_RELEASE		GIF_LIBRARY)

	dk_set		(giflib_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY})

	### GENERATE / CONFIGURE ###
	dk_chdir	(${giflib})
	dk_depend	(bash)
	dk_exec		(${bash_exe} -c "autoreconf -f -i")
	string(REPLACE "-std=c17" "" giflib_CONFIGURE "${DKCONFIGURE_BUILD}")
	string(REPLACE "-std=c++1z" "" giflib_CONFIGURE "${giflib_CONFIGURE}")
	string(REPLACE "  " " " giflib_CONFIGURE "${giflib_CONFIGURE}")

	dk_configure(${giflib})
	if(Android)
		if(MSVC)
			dk_visualStudio	(${giflib} giflib)
		else()
			dk_exec			(make -C lib)
		endif()
	else()
		if(Emscripten)
			dk_build		(${giflib})
		else()
			dk_exec			(make -C lib)
		endif()
	endif()
endif()

# FIX for other searchers
#dk_copy(${giflib}/gif_lib.h ${giflib}/lib/gif_lib.h)
