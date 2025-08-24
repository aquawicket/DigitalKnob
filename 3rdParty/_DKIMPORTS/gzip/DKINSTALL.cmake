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


############ gzip ############
# https://git.savannah.gnu.org/cgit/gzip.git
# git://git.savannah.gnu.org/gzip.git
# https://github.com/kunpengcompute/gzip.git

dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://github.com/kunpengcompute/gzip/archive/6a3ebab7e475fb5ca9b01c344eb45c27ea81ef89.zip)

### LINK ###
dk_include				(${GZIP}						GZIP_INCLUDE_DIR)
dk_include				(${GZIP.Build_Dir}/lib				GZIP_INCLUDE_DIR2)

# libversion
Unix_dk_libDebug		(${GZIP.Debug_Dir}/libver.a			VER_DEBUG_LIBRARY)
Unix_dk_libRelease		(${GZIP.Release_Dir}/libver.a		VER_RELEASE_LIBRARY)
Windows_dk_libDebug		(${GZIP.Debug_Dir}/ver.a			VER_DEBUG_LIBRARY)
Windows_dk_libRelease	(${GZIP.Release_Dir}/ver.a			VER_RELEASE_LIBRARY)

# libgzip
Unix_dk_libDebug		(${GZIP.Debug_Dir}/lib/libgzip.a	GZIP_DEBUG_LIBRARY)
Unix_dk_libRelease		(${GZIP.Release_Dir}/lib/libgzip.a	GZIP_RELEASE_LIBRARY)
Windows_dk_libDebug		(${GZIP.Debug_Dir}/lib/gzip.a		GZIP_DEBUG_LIBRARY)
Windows_dk_libRelease	(${GZIP.Release_Dir}/lib/gzip.a		GZIP_RELEASE_LIBRARY)
Debug_dk_set			(GZIP_LIBRARY						${GZIP_DEBUG_LIBRARY})
Release_dk_set			(GZIP_LIBRARY						${GZIP_RELEASE_LIBRARY})

### 3RDPARTY LINK ###
dk_set(GZIP_CMAKE 
	-DGZIP_INCLUDE_DIR=${GZIP_INCLUDE_DIR} 
	-DGZIP_LIBRARY=${GZIP_LIBRARY})

### GENERATE / COMPILE ###
string(REPLACE "--disable-shared" 	"" 	DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "--enable-static" 	"" 	DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "  " 				" " DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")


Android_dk_configure			(${GZIP})
Android_dk_build				(${GZIP})

#Apple_dk_chdir					(${GZIP})
Apple_dk_exec					(chmod 777 configure)
Apple_dk_exec					(chmod 777 build-aux/git-version-gen)
Apple_dk_exec					(chmod 777 build-aux/install-sh)
#Apple_Debug_dk_chdir			(${GZIP.Debug_Dir})
Apple_Debug_dk_configure		(${GZIP} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP.Debug_Dir}/lib")
#Apple_Debug_dk_exec			(make version)
#Apple_Debug_dk_exec			(make gzip)
#Apple_Release_dk_chdir			(${GZIP.Release_Dir})
Apple_Release_dk_exec			(${GZIP_CONFIGURE} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP.Release_Dir}/lib")
#Apple_Release_dk_exec			(make version)
#Apple_Release_dk_exec			(make gzip)
Apple_dk_build					(${GZIP})

#Emscripten_dk_chdir			(${GZIP})
Emscripten_dk_exec				(chmod 777 configure)
Emscripten_dk_exec				(chmod 777 build-aux/git-version-gen)
Emscripten_dk_exec				(chmod 777 build-aux/install-sh)
#Emscripten_Debug_dk_chdir		(${GZIP.Debug_Dir})
Emscripten_Debug_dk_configure	(${GZIP})
#Emscripten_Release_dk_chdir	(${GZIP.Release_Dir})
Emscripten_Release_dk_configure	(${GZIP})
Emscripten_dk_build				(${GZIP})

#Linux_dk_chdir					(${GZIP})
Linux_dk_exec					(chmod 777 configure)
Linux_dk_exec					(chmod 777 build-aux/git-version-gen)
Linux_dk_exec					(chmod 777 build-aux/install-sh)
#Linux_Debug_dk_chdir			(${GZIP.Debug_Dir})
Linux_Debug_dk_configure		(${GZIP})
#Linux_Release_dk_chdir			(${GZIP.Release_Dir})
Linux_Release_dk_configure		(${GZIP})
Linux_dk_build					(${GZIP})

#Raspberry_dk_chdir				(${GZIP})
Raspberry_dk_exec				(chmod 777 configure)
Raspberry_dk_exec				(chmod 777 build-aux/git-version-gen)
Raspberry_dk_exec				(chmod 777 build-aux/install-sh)
#Raspberry_Debug_dk_chdir		(${GZIP.Debug_Dir})
Raspberry_Debug_dk_configure	(${GZIP})
#Raspberry_Release_dk_chdir		(${GZIP.Release_Dir})
Raspberry_Release_dk_configure	(${GZIP})
Raspberry_dk_build				(${GZIP})

#Windows_dk_chdir				(${GZIP})
#Windows_dk_exec				(touch aclocal.m4 configure Makefile.am Makefile.in)
#Windows_Debug_dk_chdir			(${GZIP.Debug_Dir})
Windows_Debug_dk_configure		(${GZIP} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP.Debug_Dir}/lib")
#Windows_Release_dk_chdir		(${GZIP.Release_Dir})
Windows_Release_dk_configure	(${GZIP} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP.Release_Dir}/lib")

Windows_dk_build				(${GZIP} gzip)
