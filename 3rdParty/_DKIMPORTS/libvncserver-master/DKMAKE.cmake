### DEPENDS ###
DKDEPEND(zlib)
DKDEPEND(libpng)
IF(ANDROID)
	DKDEPEND(jpeg)
ELSE()
	DKDEPEND(libjpeg-turbo)
ENDIF()
DKDEPEND(openssl-vs2015)
IF(LINUX)
	DKDEPEND(libsystemd-dev)
ENDIF()


### INSTALL ###
## DKINSTALL(www.internet.com/libvncserver-master.zip libvncserver-master) ## find an online link
DKSET(VNCSERVER ${3RDPARTY}/libvncserver-master)


### LINK ###
DKINCLUDE(${VNCSERVER})
DKINCLUDE(${VNCSERVER}/examples)
DKINCLUDE(${VNCSERVER}/${OS})
DKINCLUDE(${VNCSERVER}/${OS}/${RELEASE})
WIN_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/vncserver.lib)
WIN_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/vncserver.lib)
WIN_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/vncclient.lib)
WIN_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/vncclient.lib)
MAC_DEBUG_LIB(${VNCSERVER}/${OS}/${DEBUG}/libvncserver.a)
MAC_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/libvncserver.a)
MAC_DEBUG_LIB(${VNCSERVER}/${OS}/${DEBUG}/libvncclient.a)
MAC_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/libvncclient.a)
IOSSIM_DEBUG_LIB(${VNCSERVER}/${OS}/${DEBUG}/lib/.libs/libvncserver.a)
IOSSIM_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/lib/.libs/libvncserver.a)
LINUX_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/libvncserver.a)
LINUX_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/libvncserver.a)
LINUX_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/libvncclient.a)
LINUX_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/libvncclient.a)
ANDROID_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/obj/local/armeabi-v7a/libvncserver.a)
ANDROID_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libvncserver.a)



DKSETPATH(${VNCSERVER}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS} /I${PNG}/${OS} /I${JPEG}/${OS}" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib -DPNG_PNG_INCLUDE_DIR=${PNG} -DPNG_LIBRARY_DEBUG=${PNG}/${OS}/Debug/libpng17_staticd.lib -DPNG_LIBRARY_RELEASE=${PNG}/${OS}/${RELEASE}/libpng17_static.lib -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE}/turbojpeg-static.lib -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/Debug/zlibstatic.lib -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE}/zlibstatic.lib -DWITH_JPEG=ON ${VNCSERVER})
WIN32_VS_DEBUG(libvncserver-master LibVNCServer.sln vncserver)
WIN32_VS_RELEASE(libvncserver-master LibVNCServer.sln vncserver)
WIN32_VS_DEBUG(libvncserver-master LibVNCServer.sln vncclient)
WIN32_VS_RELEASE(libvncserver-master LibVNCServer.sln vncclient)

DKSETPATH(${VNCSERVER}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN32 /DWIN64 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS} /I${PNG}/${OS} /I${JPEG}/${OS}" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include64 -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib -DPNG_PNG_INCLUDE_DIR=${PNG} -DPNG_LIBRARY_DEBUG=${PNG}/${OS}/Debug/libpng17_staticd.lib -DPNG_LIBRARY_RELEASE=${PNG}/${OS}/${RELEASE}/libpng17_static.lib -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE}/turbojpeg-static.lib -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/Debug/zlibstatic.lib -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE}/zlibstatic.lib -DWITH_JPEG=ON ${VNCSERVER})
WIN64_VS_DEBUG(libvncserver-master LibVNCServer.sln vncserver)
WIN64_VS_RELEASE(libvncserver-master LibVNCServer.sln vncserver)
WIN64_VS_DEBUG(libvncserver-master LibVNCServer.sln vncclient)
WIN64_VS_RELEASE(libvncserver-master LibVNCServer.sln vncclient)

DKSETPATH(${VNCSERVER}/${OS})
MAC64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 "-DCMAKE_C_FLAGS=-I${PNG}/${OS} -I${JPEG}/${OS}" -DPNG_PNG_INCLUDE_DIR=${PNG} -DPNG_LIBRARY_DEBUG=${PNG}/${OS}/${DEBUG}/libpng17d.a -DPNG_LIBRARY_RELEASE=${PNG}/${OS}/${RELEASE}/libpng17.a -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE}/libturbojpeg.a -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE}/libz.a -DWITH_JPEG=ON ${VNCSERVER})
MAC64_XCODE_DEBUG(libvncserver-master vncserver)
MAC64_XCODE_RELEASE(libvncserver-master vncserver)
MAC64_XCODE_DEBUG(libvncserver-master vncclient)
MAC64_XCODE_RELEASE(libvncserver-master vncclient)

DKSETPATH(${VNCSERVER}/${OS})
IOS_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS ${VNCSERVER})
IOS_XCODE_DEBUG(libvncserver-master vncserver)
IOS_XCODE_RELEASE(libvncserver-master vncserver)
IOS_XCODE_DEBUG(libvncserver-master vncclient)
IOS_XCODE_RELEASE(libvncserver-master vncclient)

DKSETPATH(${VNCSERVER}/${OS})
IOSSIM_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR ${VNCSERVER})
IOSSIM_XCODE_DEBUG(libvncserver-master vncserver)
IOSSIM_XCODE_RELEASE(libvncserver-master vncserver)
IOSSIM_XCODE_DEBUG(libvncserver-master vncclient)
IOSSIM_XCODE_RELEASE(libvncserver-master vncclient)

DKSETPATH(${VNCSERVER}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG "-DCMAKE_C_FLAGS=-fPIC -I${ZLIB}/${OS}/Debug -I${PNG}/${OS}/Debug -I${JPEG}/${OS}/Debug" -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_LIBRARY=${JPEG}/${OS}/Debug/libturbojpeg.a -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE}/libz.a -DWITH_JPEG=ON ${VNCSERVER})
LINUX_DEBUG_COMMAND(make vncserver)
LINUX_DEBUG_COMMAND(make vncclient)

DKSETPATH(${VNCSERVER}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE "-DCMAKE_C_FLAGS=-fPIC -I${ZLIB}/${OS}/${RELEASE} -I${PNG}/${OS}/${RELEASE} -I${JPEG}/${OS}/${RELEASE}" -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE}/libturbojpeg.a -DWITH_JPEG=ON -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE}/libz.a ${VNCSERVER})
LINUX_RELEASE_COMMAND(make vncserver)
LINUX_RELEASE_COMMAND(make vncclient)

ANDROID_NDK_DEBUG(libvncserver-master)
ANDROID_NDK_RELEASE(libvncserver-master)