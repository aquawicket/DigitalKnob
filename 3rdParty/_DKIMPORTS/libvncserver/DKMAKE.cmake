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
WIN_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/vncserver.lib)
WIN_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/vncserver.lib)
WIN_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/vncclient.lib)
WIN_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/vncclient.lib)
MAC_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncserver.a)
MAC_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncserver.a)
MAC_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncclient.a)
MAC_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncclient.a)
IOSSIM_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/lib/.libs/libvncserver.a)
IOSSIM_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/lib/.libs/libvncserver.a)
LINUX_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncserver.a)
LINUX_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncserver.a)
LINUX_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncclient.a)
LINUX_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncclient.a)
ANDROID_dk_libDebug(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvncserver.a)
ANDROID_dk_libRelease(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvncserver.a)


### COMPILE ###
dk_setPath(${LIBVNCSERVER}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${OPENSSL_CMAKE} ${PNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${JPEG_CMAKE} ${LIBVNCSERVER})


WIN_dk_visualStudio(${LIBVNCSERVER_NAME} vncserver)
WIN_dk_visualStudio(${LIBVNCSERVER_NAME} vncclient)

MAC_dk_xcode(${LIBVNCSERVER_NAME} vncserver)
MAC_dk_xcode(${LIBVNCSERVER_NAME} vncclient)

IOS_dk_xcode(${LIBVNCSERVER_NAME} vncserver)
IOS_dk_xcode(${LIBVNCSERVER_NAME} vncclient)

IOSSIM_dk_xcode(${LIBVNCSERVER_NAME} vncserver)
IOSSIM_dk_xcode(${LIBVNCSERVER_NAME} vncclient)

LINUX_dk_queueCommand(make vncserver)
LINUX_dk_queueCommand(make vncclient)

ANDROID_dk_visualStudio(${LIBVNCSERVER_NAME} vncserver)
ANDROID_dk_visualStudio(${LIBVNCSERVER_NAME} vncclient)