# https://github.com/LibVNC/libvncserver/archive/refs/heads/master-win.zip


### DEPEND ###
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(openssl)
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/LibVNC/libvncserver/archive/refs/heads/master-win.zip)


### LINK ###
dk_include			(${LIBVNCSERVER-MASTER-WIN})
dk_include			(${LIBVNCSERVER-MASTER-WIN}/examples)
dk_include			(${LIBVNCSERVER-MASTER-WIN}/${OS})
DEBUG_dk_include	(${LIBVNCSERVER-MASTER-WIN}/${OS}/${DEBUG_DIR})
RELEASE_dk_include	(${LIBVNCSERVER-MASTER-WIN}/${OS}/${RELEASE_DIR})
dk_libDebug			(${LIBVNCSERVER-MASTER-WIN}/${OS}/${DEBUG_DIR}/vncserver.lib)
dk_libRelease		(${LIBVNCSERVER-MASTER-WIN}/${OS}/${RELEASE_DIR}/vncserver.lib)
dk_libDebug			(${LIBVNCSERVER-MASTER-WIN}/${OS}/${DEBUG_DIR}/vncclient.lib)
dk_libRelease		(${LIBVNCSERVER-MASTER-WIN}/${OS}/${RELEASE_DIR}/vncclient.lib)


### GENERATE ###
dk_setPath		(${LIBVNCSERVER-MASTER-WIN}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${OPENSSL_CMAKE} ${ZLIB_CMAKE} ${LIBVNCSERVER-MASTER-WIN})


### COMPILE ###
dk_visualStudio(${VNCSERVER_NAME} vncserver)
dk_visualStudio(${VNCSERVER_NAME} vncclient)
