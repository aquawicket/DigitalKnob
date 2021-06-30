### DEPENDS ###
DKDEPEND(zlib)
DKDEPEND(libpng)
IF(ANDROID)
	DKDEPEND(jpeg)
ELSE()
	DKDEPEND(libjpeg-turbo)
ENDIF()
DKDEPEND(openssl-vs2015)


### INSTALL ###
## DKINSTALL(www.internet.com/libvncserver-master-win.zip libvncserver-master-win) ## find an online link
DKSET(VNCSERVER ${3RDPARTY}/libvncserver-master-win)


### LINK ###
DKINCLUDE(${VNCSERVER})
DKINCLUDE(${VNCSERVER}/examples)
DKINCLUDE(${VNCSERVER}/${OS})
DKINCLUDE(${VNCSERVER}/${OS}/${RELEASE})
WIN_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/vncserver.lib)
WIN_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/vncserver.lib)
WIN_DEBUG_LIB(${VNCSERVER}/${OS}/Debug/vncclient.lib)
WIN_RELEASE_LIB(${VNCSERVER}/${OS}/${RELEASE}/vncclient.lib)


### COMPILE ###
DKSETPATH(${VNCSERVER}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS} /I${PNG}/${OS} /I${JPEG}/${OS}" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DCMAKE_USE_OPENSSL=ON -DOPENSSL_INCLUDE_DIR=${OPENSSL}/include -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib -DPNG_PNG_INCLUDE_DIR=${PNG} -DPNG_LIBRARY_DEBUG=${PNG}/${OS}/Debug/libpng17_staticd.lib -DPNG_LIBRARY_RELEASE=${PNG}/${OS}/${RELEASE}/libpng17_static.lib -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE}/turbojpeg-static.lib -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/Debug/zlibstatic.lib -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE}/zlibstatic.lib -DWITH_JPEG=ON ${VNCSERVER})
WIN32_VS_DEBUG(libvncserver-master-win LibVNCServer.sln vncserver)
WIN32_VS_RELEASE(libvncserver-master-win LibVNCServer.sln vncserver)
WIN32_VS_DEBUG(libvncserver-master-win LibVNCServer.sln vncclient)
WIN32_VS_RELEASE(libvncserver-master-win LibVNCServer.sln vncclient)

DKSETPATH(${VNCSERVER}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${VNCSERVER})
WIN64_VS_DEBUG(libvncserver-master-win LibVNCServer.sln vncserver)
WIN64_VS_RELEASE(libvncserver-master-win LibVNCServer.sln vncserver)
WIN64_VS_DEBUG(libvncserver-master-win LibVNCServer.sln vncclient)
WIN64_VS_RELEASE(libvncserver-master-win LibVNCServer.sln vncclient)