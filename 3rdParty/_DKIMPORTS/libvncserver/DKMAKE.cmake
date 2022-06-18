# https://github.com/LibVNC/libvncserver

### DEPENDS ###
dk_depend(zlib)
dk_depend(libpng)
IF(ANDROID)
	dk_depend(jpeg)
ELSE()
	dk_depend(libjpeg-turbo)
ENDIF()
dk_depend(openssl)
LINUX_dk_depend(libsystemd-dev)



dk_import(https://github.com/LibVNC/libvncserver)



### LINK ###
dk_include(${LIBVNCSERVER})
dk_include(${LIBVNCSERVER}/examples)
dk_include(${LIBVNCSERVER}/${OS})
dk_include(${LIBVNCSERVER}/${OS}/${RELEASE_DIR})
WIN_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/vncserver.lib)
WIN_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/vncserver.lib)
WIN_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/vncclient.lib)
WIN_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/vncclient.lib)
MAC_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncserver.a)
MAC_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncserver.a)
MAC_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncclient.a)
MAC_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncclient.a)
IOSSIM_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/lib/.libs/libvncserver.a)
IOSSIM_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/lib/.libs/libvncserver.a)
LINUX_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncserver.a)
LINUX_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncserver.a)
LINUX_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncclient.a)
LINUX_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncclient.a)
ANDROID_DEBUG_DKLIB(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvncserver.a)
ANDROID_RELEASE_DKLIB(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvncserver.a)


### COMPILE ###
dk_setPath(${LIBVNCSERVER}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${OPENSSL_CMAKE} ${PNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${JPEG_CMAKE} ${LIBVNCSERVER})


WIN_VS(${LIBVNCSERVER_NAME} LibVNCServer.sln vncserver)
WIN_VS(${LIBVNCSERVER_NAME} LibVNCServer.sln vncclient)

MAC_XCODE(${LIBVNCSERVER_NAME} vncserver)
MAC_XCODE(${LIBVNCSERVER_NAME} vncclient)

IOS_XCODE(${LIBVNCSERVER_NAME} vncserver)
IOS_XCODE(${LIBVNCSERVER_NAME} vncclient)

IOSSIM_XCODE(${LIBVNCSERVER_NAME} vncserver)
IOSSIM_XCODE(${LIBVNCSERVER_NAME} vncclient)

LINUX_DKQCOMMAND(make vncserver)
LINUX_DKQCOMMAND(make vncclient)

ANDROID_VS(${LIBVNCSERVER_NAME} LibVNCServer.sln vncserver)
ANDROID_VS(${LIBVNCSERVER_NAME} LibVNCServer.sln vncclient)