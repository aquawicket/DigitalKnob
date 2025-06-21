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
dk_include				(${GZIP_DIR}						GZIP_INCLUDE_DIR)
dk_include				(${GZIP_BUILD_DIR}/lib				GZIP_INCLUDE_DIR2)

# libversion
Unix_dk_libDebug		(${GZIP_DEBUG_DIR}/libver.a			VER_DEBUG_LIBRARY)
Unix_dk_libRelease		(${GZIP_RELEASE_DIR}/libver.a		VER_RELEASE_LIBRARY)
Windows_dk_libDebug		(${GZIP_DEBUG_DIR}/ver.a			VER_DEBUG_LIBRARY)
Windows_dk_libRelease	(${GZIP_RELEASE_DIR}/ver.a			VER_RELEASE_LIBRARY)

# libgzip
Unix_dk_libDebug		(${GZIP_DEBUG_DIR}/lib/libgzip.a	GZIP_DEBUG_LIBRARY)
Unix_dk_libRelease		(${GZIP_RELEASE_DIR}/lib/libgzip.a	GZIP_RELEASE_LIBRARY)
Windows_dk_libDebug		(${GZIP_DEBUG_DIR}/lib/gzip.a		GZIP_DEBUG_LIBRARY)
Windows_dk_libRelease	(${GZIP_RELEASE_DIR}/lib/gzip.a		GZIP_RELEASE_LIBRARY)
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


Android_dk_configure			(${GZIP_DIR})
Android_dk_build				(${GZIP_DIR})

#Apple_dk_chdir					(${GZIP_DIR})
Apple_dk_exec					(chmod 777 configure)
Apple_dk_exec					(chmod 777 build-aux/git-version-gen)
Apple_dk_exec					(chmod 777 build-aux/install-sh)
#Apple_Debug_dk_chdir			(${GZIP_DEBUG_DIR})
Apple_Debug_dk_configure		(${GZIP_DIR} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP_DEBUG_DIR}/lib")
#Apple_Debug_dk_exec			(make version)
#Apple_Debug_dk_exec			(make gzip)
#Apple_Release_dk_chdir			(${GZIP_RELEASE_DIR})
Apple_Release_dk_exec			(${GZIP_CONFIGURE} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP_RELEASE_DIR}/lib")
#Apple_Release_dk_exec			(make version)
#Apple_Release_dk_exec			(make gzip)
Apple_dk_build					(${GZIP_DIR})

#Emscripten_dk_chdir			(${GZIP})
Emscripten_dk_exec				(chmod 777 configure)
Emscripten_dk_exec				(chmod 777 build-aux/git-version-gen)
Emscripten_dk_exec				(chmod 777 build-aux/install-sh)
#Emscripten_Debug_dk_chdir		(${GZIP_DEBUG_DIR})
Emscripten_Debug_dk_configure	(${GZIP_DIR})
#Emscripten_Release_dk_chdir	(${GZIP_RELEASE_DIR})
Emscripten_Release_dk_configure	(${GZIP_DIR})
Emscripten_dk_build				(${GZIP_DIR})

#Linux_dk_chdir					(${GZIP_DIR})
Linux_dk_exec					(chmod 777 configure)
Linux_dk_exec					(chmod 777 build-aux/git-version-gen)
Linux_dk_exec					(chmod 777 build-aux/install-sh)
#Linux_Debug_dk_chdir			(${GZIP_DEBUG_DIR})
Linux_Debug_dk_configure		(${GZIP_DIR})
#Linux_Release_dk_chdir			(${GZIP_RELEASE_DIR})
Linux_Release_dk_configure		(${GZIP_DIR})
Linux_dk_build					(${GZIP_DIR})

#Raspberry_dk_chdir				(${GZIP_DIR})
Raspberry_dk_exec				(chmod 777 configure)
Raspberry_dk_exec				(chmod 777 build-aux/git-version-gen)
Raspberry_dk_exec				(chmod 777 build-aux/install-sh)
#Raspberry_Debug_dk_chdir		(${GZIP_DEBUG_DIR})
Raspberry_Debug_dk_configure	(${GZIP_DIR})
#Raspberry_Release_dk_chdir		(${GZIP_RELEASE_DIR})
Raspberry_Release_dk_configure	(${GZIP_DIR})
Raspberry_dk_build				(${GZIP_DIR})

#Windows_dk_chdir				(${GZIP_DIR})
#Windows_dk_exec				(touch aclocal.m4 configure Makefile.am Makefile.in)
#Windows_Debug_dk_chdir			(${GZIP_DEBUG_DIR})
Windows_Debug_dk_configure		(${GZIP_DIR} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP_DEBUG_DIR}/lib")
#Windows_Release_dk_chdir		(${GZIP_RELEASE_DIR})
Windows_Release_dk_configure	(${GZIP_DIR} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP_RELEASE_DIR}/lib")

Windows_dk_build				(${GZIP_DIR} gzip)
