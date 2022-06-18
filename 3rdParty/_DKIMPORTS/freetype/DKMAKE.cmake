# https://www.freetype.org/
#
# https://sourceforge.net/projects/freetype/files/freetype2/2.5.5/freetype-2.5.5.tar.gz


### VERSION ###
dk_set(FREETYPE_MAJOR 2)
dk_set(FREETYPE_MINOR 5)
dk_set(FREETYPE_BUILD 5)
dk_set(FREETYPE_VERSION ${FREETYPE_MAJOR}.${FREETYPE_MINOR}.${FREETYPE_BUILD})
dk_set(FREETYPE_NAME freetype-${FREETYPE_VERSION})
dk_set(FREETYPE_DL https://sourceforge.net/projects/freetype/files/freetype2/${FREETYPE_MAJOR}.${FREETYPE_MINOR}.${FREETYPE_BUILD}/${FREETYPE_NAME}.tar.gz)
dk_set(FREETYPE ${3RDPARTY}/${FREETYPE_NAME})


### INSTALL ###
dk_install(${FREETYPE_DL} freetype ${FREETYPE} PATCH)


### DKPLUGINS LINK ###
dk_include(${FREETYPE}/include)
dk_include(${FREETYPE}/${OS}/include/freetype2)
WIN_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib)
WIN_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib)
MAC_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
MAC_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
IOS_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
IOS_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
IOSSIM_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
IOSSIM_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
LINUX_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
LINUX_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
RASPBERRY_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
RASPBERRY_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
ANDROID_dk_libDebug(${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a)
ANDROID_dk_libRelease(${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)



### 3RDPARTY LINK ###
WIN_dk_set(FREETYPE_CMAKE -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib)
APPLE_dk_set(FREETYPE_CMAKE -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
LINUX_dk_set(FREETYPE_CMAKE -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
RASPBERRY_dk_set(FREETYPE_CMAKE -DFREETYPE_DIR=${FREETYPE} -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
ANDROID_dk_set(FREETYPE_CMAKE -DFREETYPE_INCLUDE_DIRS=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/${OS}/include/freetype2 -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/libfreetype.a -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/libfreetype.a)
	
	
	
### COMPILE ###
dk_setPath(${FREETYPE}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${FREETYPE})


WIN_dk_VisualStudio(${FREETYPE_NAME} freetype.sln freetype)
MAC_dk_xcode(${FREETYPE_NAME} freetype)
IOS_dk_xcode(${FREETYPE_NAME} freetype)
IOSSIM_dk_xcode(${FREETYPE_NAME} freetype)
LINUX_dk_queueCommand(make freetype)
RASPBERRY_dk_queueCommand(make freetype)
ANDROID_dk_VisualStudio(${FREETYPE_NAME} freetype.sln freetype)
