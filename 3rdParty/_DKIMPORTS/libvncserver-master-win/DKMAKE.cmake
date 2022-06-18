#dk_set(VNCSERVER_DL https://github.com/LibVNC/libvncserver/archive/refs/heads/master-win.zip)

### DEPENDS ###
dk_depend(zlib)
dk_depend(libpng)
IF(ANDROID)
	dk_depend(jpeg)
ELSE()
	dk_depend(libjpeg-turbo)
ENDIF()
dk_depend(openssl)


dk_set(VNCSERVER_VERSION master-win)
dk_set(VNCSERVER_NAME libvncserver-${VNCSERVER_VERSION})
dk_set(VNCSERVER_DL https://github.com/LibVNC/libvncserver/archive/refs/heads/${VNCSERVER_VERSION}.zip)
dk_set(VNCSERVER ${3RDPARTY}/${VNCSERVER_NAME})


### INSTALL ###
dk_install(${VNCSERVER_DL} libvncserver-master_win ${VNCSERVER})



### LINK ###
dk_include(${VNCSERVER})
dk_include(${VNCSERVER}/examples)
dk_include(${VNCSERVER}/${OS})
dk_include(${VNCSERVER}/${OS}/${RELEASE_DIR})
WIN_dk_libDebug(${VNCSERVER}/${OS}/${DEBUG_DIR}/vncserver.lib)
WIN_dk_libRelease(${VNCSERVER}/${OS}/${RELEASE_DIR}/vncserver.lib)
WIN_dk_libDebug(${VNCSERVER}/${OS}/${DEBUG_DIR}/vncclient.lib)
WIN_dk_libRelease(${VNCSERVER}/${OS}/${RELEASE_DIR}/vncclient.lib)


### COMPILE ###
WIN_dk_setPath(${VNCSERVER}/${OS})
WIN_dk_queueCommand(${DKCMAKE_BUILD} -DWITH_JPEG=ON ${OPENSSL_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${ZLIB_CMAKE} ${VNCSERVER})
WIN_dk_VisualStudio(${VNCSERVER_NAME} LibVNCServer.sln vncserver)
WIN_dk_VisualStudio(${VNCSERVER_NAME} LibVNCServer.sln vncclient)
