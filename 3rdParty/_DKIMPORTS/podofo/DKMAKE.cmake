# http://podofo.sourceforge.net
# https://github.com/mekentosj/podofo


### DEPENDS ###
dk_depend(zlib)
dk_depend(freetype)
dk_depend(libpng)


### IMPORT ###
dk_import(http://sourceforge.net/projects/podofo/files/podofo/0.9.7/podofo-0.9.7.tar.gz)
#dk_import(https://github.com/mekentosj/podofo.git)


### LINK ###
dk_include(${PODOFO})
dk_include(${PODOFO}/podofo)
dk_include(${PODOFO}/${OS})
dk_include(${PODOFO}/${OS}/${RELEASE_DIR})
WIN_dk_libDebug(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/podofo.lib)
WIN_dk_libRelease(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/podofo.lib)
MAC_dk_libDebug(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/libpodofo.a)
MAC_dk_libRelease(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/libpodofo.a)
IOS_dk_libDebug(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/libpodofo.a)
IOS_dk_libRelease(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/libpodofo.a)
IOSSIM_dk_libDebug(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/libpodofo.a)
IOSSIM_dk_libRelease(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/libpodofo.a)
#LINUX_dk_libDebug(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/libpodofo.a)
#LINUX_dk_libRelease(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/libpodofo.a)
LINUX_dk_libDebug(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
LINUX_dk_libRelease(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)
ANDROID_dk_libDebug(${PODOFO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libpodofo.a)
ANDROID_dk_libRelease(${PODOFO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libpodofo.a)


### GENERATE ###
dk_setPath(${PODOFO}/${BUILD_DIR})
WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${ZLIB}/${OS}" -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
MAC_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO}) #-DPODOFO_NO_FONTMANAGER=ON
IOS_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO}) #-DPODOFO_NO_FONTMANAGER=ON
IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO}) #-DPODOFO_NO_FONTMANAGER=ON
LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
ANDROID_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${ZLIB}/${OS}" -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})


### COMPILE ###
WIN_dk_visualStudio(podofo-${PODOFO_VERSION} podofo_static)
MAC_dk_xcode(podofo-${PODOFO_VERSION} podofo_static)
IOS_dk_xcode(podofo-${PODOFO_VERSION} podofo_static)
IOSSIM_dk_xcode(podofo-${PODOFO_VERSION} podofo_static)
LINUX_dk_queueCommand(make podofo_static)
ANDROID_dk_visualStudio(podofo-${PODOFO_VERSION} podofo_static)
