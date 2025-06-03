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


dk_validate(Config_Path  "dk_Config_Path()")
# https://github.com/arvidn/libtorrent
# https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/libtorrent-rasterbar-1.1.3.tar.gz
# https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.4.zip


### DEPENDS ###
dk_depend(boost boost_system)
dk_depend(openssl)


### IMPORT ###
#dk_import(https://github.com/arvidn/libtorrent.git)
dk_import(https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.7.zip)



### LINK ###
dk_include				(${LIBTORRENT}/include)
ANDROID_dk_libDebug		(${LIBTORRENT_DEBUG_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
ANDROID_dk_libRelease	(${LIBTORRENT_RELEASE_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
EMSCRIPTEN_dk_libDebug	(${LIBTORRENT_DEBUG_DIR}/libtorrent-rasterbar.a)
EMSCRIPTEN_dk_libRelease(${LIBTORRENT_RELEASE_DIR}/libtorrent-rasterbar.a)
IOSSIM_dk_libDebug		(${LIBTORRENT_DEBUG_DIR}/lib/.libs/libtorrent-rasterbar.a)
IOSSIM_dk_libRelease	(${LIBTORRENT_RELEASE_DIR}/lib/.libs/libtorrent-rasterbar.a)
LINUX_dk_libDebug		(${LIBTORRENT_DEBUG_DIR}/libtorrent-rasterbar.a)
LINUX_dk_libRelease		(${LIBTORRENT_RELEASE_DIR}/libtorrent-rasterbar.a)
MAC_dk_libDebug			(${LIBTORRENT}/${Target_Tuple}/lib/${Debug_Dir}/libtorrent-rasterbar.a)
MAC_dk_libRelease		(${LIBTORRENT}/${Target_Tuple}/lib/${Release_Dir}/libtorrent-rasterbar.a)
Windows_dk_libDebug			(${LIBTORRENT_DEBUG_DIR}/torrent-rasterbar.lib)
Windows_dk_libRelease		(${LIBTORRENT_RELEASE_DIR}/torrent-rasterbar.lib)


### GENERATE ###
dk_configure(${LIBTORRENT} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON ${BOOST_CMAKE} ${OPENSSL_CMAKE})


### COMPILE ###
dk_build(${LIBTORRENT})
#dk_build(${LIBTORRENT} torrent-rasterbar)
