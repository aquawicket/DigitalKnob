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


############ libtorrent ############
# https://github.com/arvidn/libtorrent
# https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/libtorrent-rasterbar-1.1.3.tar.gz
# https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.4.zip
# https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.7.zip

dk_depend(boost boost_system)
dk_depend(openssl)

dk_import()

dk_include				(${libtorrent}/include)
Android_dk_libDebug		(${libtorrent_Debug_Dir}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
Android_dk_libRelease	(${libtorrent_Release_Dir}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
Emscripten_dk_libDebug	(${libtorrent_Debug_Dir}/libtorrent-rasterbar.a)
Emscripten_dk_libRelease(${libtorrent_Release_Dir}/libtorrent-rasterbar.a)
Iossim_dk_libDebug		(${libtorrent_Debug_Dir}/lib/.libs/libtorrent-rasterbar.a)
Iossim_dk_libRelease	(${libtorrent_Release_Dir}/lib/.libs/libtorrent-rasterbar.a)
Linux_dk_libDebug		(${libtorrent_Debug_Dir}/libtorrent-rasterbar.a)
Linux_dk_libRelease		(${libtorrent_Release_Dir}/libtorrent-rasterbar.a)
Mac_dk_libDebug			(${libtorrent}/${Target_Tuple}/lib/${Debug_Dir}/libtorrent-rasterbar.a)
Mac_dk_libRelease		(${libtorrent}/${Target_Tuple}/lib/${Release_Dir}/libtorrent-rasterbar.a)
Windows_dk_libDebug		(${libtorrent_Debug_Dir}/torrent-rasterbar.lib)
Windows_dk_libRelease	(${libtorrent_Release_Dir}/torrent-rasterbar.lib)

dk_configure(${libtorrent} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON ${BOOST_CMAKE} ${openssl_CMAKE})

dk_build()
#dk_build(${libtorrent} torrent-rasterbar)
