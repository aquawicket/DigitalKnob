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


############ gzip ############
# https://git.savannah.gnu.org/cgit/gzip.git
# git://git.savannah.gnu.org/gzip.git
# https://github.com/kunpengcompute/gzip.git
# https://github.com/kunpengcompute/gzip/archive/6a3ebab7.zip

dk_import()

dk_include			(${gzip}							GZIP_INCLUDE_DIR)
dk_include			(${gzip}/include					GZIP_INCLUDE_DIR2)
dk_include			(${gzip_Build_Dir}/lib				GZIP_INCLUDE_DIR3)

# libversion
if(Windows)
	dk_libDebug		(${gzip_Debug_Dir}/ver.a			VER_DEBUG_LIBRARY		VER_LIBRARY)
	dk_libRelease	(${gzip_Release_Dir}/ver.a			VER_RELEASE_LIBRARY		VER_LIBRARY)
else()
	dk_libDebug		(${gzip_Debug_Dir}/libver.a			VER_DEBUG_LIBRARY		VER_LIBRARY)
	dk_libRelease	(${gzip_Release_Dir}/libver.a		VER_RELEASE_LIBRARY		VER_LIBRARY)
endif()


# libgzip
if(Windows)
	dk_libDebug		(${gzip_Debug_Dir}/lib/gzip.a		GZIP_DEBUG_LIBRARY		GZIP_LIBRARY)
	dk_libRelease	(${gzip_Release_Dir}/lib/gzip.a		GZIP_RELEASE_LIBRARY	GZIP_LIBRARY)
else()
	dk_libDebug		(${gzip_Debug_Dir}/lib/libgzip.a	GZIP_DEBUG_LIBRARY		GZIP_LIBRARY)
	dk_libRelease	(${gzip_Release_Dir}/lib/libgzip.a	GZIP_RELEASE_LIBRARY	GZIP_LIBRARY)
endif()

### 3RDPARTY LINK ###
dk_set(gzip_CMAKE 
	-DGZIP_INCLUDE_DIR=${GZIP_INCLUDE_DIR} 
	-DGZIP_LIBRARY=${GZIP_LIBRARY})

### GENERATE / COMPILE ###
string(REPLACE "--disable-shared" 	"" 	DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "--enable-static" 	"" 	DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "  " 				" " DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")


if(Apple OR Emscripten OR Linux OR Raspberry)
	#dk_chdir		(${gzip})
	dk_exec			(chmod 777 configure)
	dk_exec			(chmod 777 build-aux/git-version-gen)
	dk_exec			(chmod 777 build-aux/install-sh)
endif()
	
if(Apple)
	#dk_chdir		(${gzip_Build_Dir})
	dk_configure	(${gzip} --disable-dependency-tracking "CFLAGS=-I${GZIP_INCLUDE_DIR2} -I${GZIP_INCLUDE_DIR3}")
	#dk_exec		(make version)
	#dk_exec		(make gzip)
elseif(Windows)
	#dk_chdir		(${gzip})
	#dk_exec		(touch aclocal.m4 configure Makefile.am Makefile.in)
	dk_configure	(${gzip} --disable-dependency-tracking CFLAGS="-I${GZIP_INCLUDE_DIR2} -I${GZIP_INCLUDE_DIR3}")
else()
	dk_configure	(${gzip})
endif()


if(Windows)
	dk_build(${gzip} gzip)
else()
	dk_build()
endif()
