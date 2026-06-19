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


############ libvncserver ############
# https://github.com/LibVNC/libvncserver.git
# https://github.com/LibVNC/libvncserver/archive/f7735c48.zip

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
dk_import()

### LINK ###
dk_include				(${libvncserver}							LIBVNCSERVER_INCLUDE_DIR)
dk_include				(${libvncserver}/include)
dk_include				(${libvncserver}/examples)
dk_include				(${libvncserver_Tuple_Dir})
dk_include				(${libvncserver_Tuple_Dir}/include)
dk_include				(${libvncserver_Build_Dir})
dk_include				(${libvncserver_Build_Dir}/include)

# vncserver
if(MSVC)
	dk_libDebug		(${libvncserver_Debug_Dir}/vncserver.lib		LIBVNCSERVER_LIBRARY)
	dk_libRelease	(${libvncserver_Release_Dir}/vncserver.lib		LIBVNCSERVER_LIBRARY)
else()
	dk_libDebug		(${libvncserver_Debug_Dir}/libvncserver.a		LIBVNCSERVER_LIBRARY)
	dk_libRelease	(${libvncserver_Release_Dir}/libvncserver.a		LIBVNCSERVER_LIBRARY)
endif()

# vncclient
if(MSVC)
	dk_libDebug		(${libvncserver_Debug_Dir}/vncclient.lib		LIBVNCCLIENT_LIBRARY)
	dk_libRelease	(${libvncserver_Release_Dir}/vncclient.lib		LIBVNCCLIENT_LIBRARY)
else()
	dk_libDebug		(${libvncserver_Debug_Dir}/libvncclient.a		LIBVNCCLIENT_LIBRARY)
	dk_libRelease	(${libvncserver_Release_Dir}/libvncclient.a		LIBVNCCLIENT_LIBRARY)
endif()

### 3RDPARTY LINK ###
if(Android)
dk_set(libvncserver_CMAKE 
	"-DCMAKE_C_FLAGS=-I${LIBVNCSERVER_INCLUDE_DIR} -I${libvncserver_Build_Dir}" 
	"-DCMAKE_CXX_FLAGS=-I${LIBVNCSERVER_INCLUDE_DIR} -I${libvncserver_Build_Dir}" 
	-DLIBVNCSERVER_INCLUDE_DIR=${LIBVNCSERVER_INCLUDE_DIR} 
	-DLIBVNCSERVER_LIBRARY=${LIBVNCSERVER_LIBRARY} 
	-DLIBVNCCLIENT_LIBRARY=${LIBVNCCLIENT_LIBRARY}
)
endif()



Apple_dk_set				(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Tuple_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Tuple_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Release_Dir}/libvncclient.a)

Emscripten_Debug_dk_set		(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Debug_Dir}/libvncclient.a)

Emscripten_Release_dk_set	(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Release_Dir}/libvncclient.a)

Linux_Debug_dk_set			(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Debug_Dir}/libvncclient.a)

Linux_Release_dk_set		(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Release_Dir}/libvncclient.a)

Raspberry_Debug_dk_set		(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Debug_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Debug_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Debug_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Debug_Dir}/libvncclient.a)

Raspberry_Release_dk_set	(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Release_Dir}" "-DCMAKE_CXX_FLAGS=-I${libvncserver} -I${libvncserver_Release_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Release_Dir}/libvncserver.a -DLIBVNCCLIENT_LIBRARY=${libvncserver_Release_Dir}/libvncclient.a)

if(MSVC)
	Windows_dk_set			(libvncserver_CMAKE "/DCMAKE_C_FLAGS=/I${libvncserver} /I${libvncserver_Tuple_Dir}" "/DCMAKE_CXX_FLAGS=/I${libvncserver} /I${libvncserver_Tuple_Dir}" /DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} /DLIBVNCSERVER_LIBRARY=${libvncserver_Release_Dir}/vncserver.lib /DLIBVNCCLIENT_LIBRARY=${libvncserver_Release_Dir}/vncclient.lib)
else()
	Windows_dk_set			(libvncserver_CMAKE "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Tuple_Dir}" "-DCMAKE_CXX_FLAGS==I${libvncserver} =I${libvncserver_Tuple_Dir}" -DLIBVNCSERVER_INCLUDE_DIR=${libvncserver} -DLIBVNCSERVER_LIBRARY=${libvncserver_Release_Dir}/vncserver.lib -DLIBVNCCLIENT_LIBRARY=${libvncserver_Release_Dir}/vncclient.lib)
endif()

### GENERATE ###
Android_Debug_dk_configure		(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Android_Release_dk_configure	(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Apple_dk_configure				(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON -DWITH_LZO=OFF)
Emscripten_Debug_dk_configure	(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Emscripten_Release_dk_configure	(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Linux_Debug_dk_configure		(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Linux_Release_dk_configure		(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Raspberry_Debug_dk_configure	(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
Raspberry_Release_dk_configure	(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Build_Dir}" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)

if(MSVC)
	Windows_dk_configure			(${libvncserver} "/DCMAKE_C_FLAGS=/I${libvncserver} /I${libvncserver_Tuple_Dir}/include" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} /DWITH_JPEG=ON)
else()
	Windows_dk_configure			(${libvncserver} "-DCMAKE_C_FLAGS=-I${libvncserver} -I${libvncserver_Tuple_Dir}/include" ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${openssl_CMAKE} ${sdl_CMAKE} ${zlib_CMAKE} -DWITH_JPEG=ON)
endif()

### PATCH ###
if(Apple OR Emscripten)
	dk_fileReplace(${libvncserver}/${Target_Config}/rfb/rfbconfig.h "\n#include <unistd.h>" "")
	dk_fileReplace(${libvncserver}/${Target_Config}/rfb/rfbconfig.h "UNISTD_H  1" "UNISTD_H  1 \n#include <unistd.h>")
endif()

### COMPILE ###
dk_build(${libvncserver} vncserver)
dk_build(${libvncserver} vncclient)
