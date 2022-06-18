# http://podofo.sourceforge.net


dk_depend(zlib)
dk_depend(freetype)
dk_depend(libpng)


dk_import(http://sourceforge.net/projects/podofo/files/podofo/0.9.7/podofo-0.9.7.tar.gz)

#dk_set(PODOFO_VERSION 0.9.5)
#dk_set(POFODO_DL http://sourceforge.net/projects/podofo/files/podofo/0.9.7/podofo-0.9.7.tar.gz/download)
#dk_set(PODOFO ${3RDPARTY}/podofo-${PODOFO_VERSION})
#dk_install(${POFODO_DL} podofo ${PODOFO})



### LINK ###
dk_include(${PODOFO})
dk_include(${PODOFO}/podofo)
dk_include(${PODOFO}/${OS})
dk_include(${PODOFO}/${OS}/${RELEASE_DIR})
WIN_DEBUG_DKLIB(${PODOFO}/${OS}/src/Debug/podofo.lib)
WIN_RELEASE_DKLIB(${PODOFO}/${OS}/src/${RELEASE_DIR}/podofo.lib)
MAC_DEBUG_DKLIB(${PODOFO}/${OS}/src/${DEBUG_DIR}/libpodofo.a)
MAC_RELEASE_DKLIB(${PODOFO}/${OS}/src/${RELEASE_DIR}/libpodofo.a)
IOS_DEBUG_DKLIB(${PODOFO}/${OS}/src/${DEBUG_DIR}/libpodofo.a)
IOS_RELEASE_DKLIB(${PODOFO}/${OS}/src/${RELEASE_DIR}/libpodofo.a)
IOSSIM_DEBUG_DKLIB(${PODOFO}/${OS}/src/${DEBUG_DIR}/libpodofo.a)
IOSSIM_RELEASE_DKLIB(${PODOFO}/${OS}/src/${RELEASE_DIR}/libpodofo.a)
LINUX_DEBUG_DKLIB(${PODOFO}/${OS}/Debug/src/libpodofo.a)
LINUX_RELEASE_DKLIB(${PODOFO}/${OS}/${RELEASE_DIR}/src/libpodofo.a)
ANDROID_DEBUG_DKLIB(${PODOFO}/${OS}/Debug/obj/local/armeabi-v7a/libpodofo.a)
ANDROID_RELEASE_DKLIB(${PODOFO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libpodofo.a)


### COMPILE ###
WIN_dk_setPath(${PODOFO}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${ZLIB}/${OS}" -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
WIN_VS(podofo-${PODOFO_VERSION} PoDoFo.sln podofo_static)

MAC64_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON -DPODOFO_NO_FONTMANAGER=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
MAC_XCODE(podofo-${PODOFO_VERSION} podofo_static)

IOS64_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON -DPODOFO_NO_FONTMANAGER=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
IOS_XCODE(podofo-${PODOFO_VERSION} podofo_static)

IOSSIM64_dk_queueCommand(${DCMAKE_IOSSIM64} -DPODOFO_BUILD_STATIC=ON -DPODOFO_NO_FONTMANAGER=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
IOSSIM_XCODE(podofo-${PODOFO_VERSION} podofo_static)

LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
LINUX_dk_queueCommand(make podofo_static)

ANDROID_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${ZLIB}/${OS}" -DPODOFO_BUILD_STATIC=ON ${ZLIB_CMAKE} ${FREETYPE_CMAKE} ${PNG_CMAKE} ${PODOFO})
ANDROID_VS(podofo-${PODOFO_VERSION} PoDoFo.sln podofo_static)
