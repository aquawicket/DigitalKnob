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


############ libvnc ############
# https://github.com/LibVNC/libvncserver.git

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
if(Apple)
	dk_depend(gnutls)
endif()
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(libsystemd-dev)
dk_depend(openssl)
dk_depend(sdl)
dk_depend(zlib)

### IMPORT ###
dk_import(https://github.com/LibVNC/libvncserver/archive/f7735c48.zip)

### LINK ###
dk_include				(${LIBVNCSERVER})
dk_include				(${LIBVNCSERVER}/include)
dk_include				(${LIBVNCSERVER}/examples)
dk_include				(${LIBVNCSERVER}/${Target_Tuple})
dk_include				(${LIBVNCSERVER}/${Target_Tuple}/include)
Debug_dk_include		(${LIBVNCSERVER.Debug_Dir})
Release_dk_include		(${LIBVNCSERVER.Release_Dir})
Debug_dk_include		(${LIBVNCSERVER.Debug_Dir}/include)
Release_dk_include		(${LIBVNCSERVER.Release_Dir}/include)

# vncserver
if(MSVC)
	dk_libDebug		(${LIBVNCSERVER.Debug_Dir}/vncserver.lib)
	dk_libRelease	(${LIBVNCSERVER.Release_Dir}/vncserver.lib)
else()
	dk_libDebug		(${LIBVNCSERVER.Debug_Dir}/libvncserver.a)
	dk_libRelease	(${LIBVNCSERVER.Release_Dir}/libvncserver.a)
endif()

# vncclient
if(MSVC)
	dk_libDebug		(${LIBVNCSERVER.Debug_Dir}/vncclient.lib)
	dk_libRelease	(${LIBVNCSERVER.Release_Dir}/vncclient.lib)
else()
	dk_libDebug		(${LIBVNCSERVER.Debug_Dir}/libvncclient.a)
	dk_libRelease	(${LIBVNCSERVER.Release_Dir}/libvncclient.a)
endif()

### 3RDPARTY LINK ###
Android_Debug_dk_set		(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncclient.a)
Android_Release_dk_set		(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncclient.a)
Apple_dk_set				(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER}/${Target_Tuple}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER}/${Target_Tuple}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncclient.a)
Emscripten_Debug_dk_set		(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncclient.a)
Emscripten_Release_dk_set	(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncclient.a)
Linux_Debug_dk_set			(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncclient.a)
Linux_Release_dk_set		(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncclient.a)
Raspberry_Debug_dk_set		(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Debug_Dir}/libvncclient.a)
Raspberry_Release_dk_set	(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/libvncclient.a)
if(MSVC)
	Windows_dk_set				(LIBVNCSERVER_CMAKE "/DCMAKE_C_FLAGS=/I${LIBVNCSERVER} /I${LIBVNCSERVER}/${Target_Tuple}" "/DCMAKE_CXX_FLAGS=/I${LIBVNCSERVER} /I${LIBVNCSERVER}/${Target_Tuple}" /DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} /DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/vncserver.lib /DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/vncclient.lib)
else()
	Windows_dk_set				(LIBVNCSERVER_CMAKE "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER}/${Target_Tuple}" "-DCMAKE_CXX_FLAGS==I${LIBVNCSERVER} =I${LIBVNCSERVER}/${Target_Tuple}" -DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER} -DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER.Release_Dir}/vncserver.lib -DLIBVNCCLIENT_LIBRARY=${LIBVNCSERVER.Release_Dir}/vncclient.lib)
endif()

### GENERATE ###
Android_Debug_dk_configure		(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Android_Release_dk_configure	(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Apple_dk_configure				(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON -DWITH_LZO=OFF)
Emscripten_Debug_dk_configure	(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Emscripten_Release_dk_configure	(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Linux_Debug_dk_configure		(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Linux_Release_dk_configure		(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Raspberry_Debug_dk_configure	(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Debug_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
Raspberry_Release_dk_configure	(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER.Release_Dir}" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)

if(MSVC)
	Windows_dk_configure			(${LIBVNCSERVER} "/DCMAKE_C_FLAGS=/I${LIBVNCSERVER} /I${LIBVNCSERVER}/${Target_Tuple}/include" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} /DWITH_JPEG=ON)
else()
	Windows_dk_configure			(${LIBVNCSERVER} "-DCMAKE_C_FLAGS=-I${LIBVNCSERVER} -I${LIBVNCSERVER}/${Target_Tuple}/include" ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${SDL_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON)
endif()

### PATCH ###
if(Apple OR Emscripten)
	dk_fileReplace(${LIBVNCSERVER}/${Target_Config}/rfb/rfbconfig.h "\n#include <unistd.h>" "")
	dk_fileReplace(${LIBVNCSERVER}/${Target_Config}/rfb/rfbconfig.h "UNISTD_H  1" "UNISTD_H  1 \n#include <unistd.h>")
endif()

### COMPILE ###
dk_build(${LIBVNCSERVER} vncserver)
dk_build(${LIBVNCSERVER} vncclient)
