# http://www.library.com
#
# http://www.library.com/downloads/library-1.0.0.zip

### DEPENDS ###
#DKDEPEND(depend_name)


### VERSION ###
DKSET(LIBRARY_VERSION 1.0.0)
DKSET(LIBRARY_NAME library-${LIBRARY_VERSION})
DKSET(LIBRARY_DL http://www.library.com/downloads/${LIBRARY_NAME}.zip)
DKSET(LIBRARY ${3RDPARTY}/${LIBRARY_NAME})


### INSTALL ###
DKINSTALL(${LIBRARY_DL} library ${LIBRARY})


### LINK ###
DKINCLUDE(${LIBRARY}/include)
WIN_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/libraryd.lib)
WIN_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/library.lib)
APPLE_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/liblibraryd.a)
APPLE_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/liblibrary.a)
LINUX_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/liblibraryd.a)
LINUX_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/liblibrary.a)
RASPBERRY_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/liblibraryd.a)
RASPBERRY_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/liblibrary.a)
ANDROID_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/liblibraryd.a)
ANDROID_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/liblibrary.a)


### COMPILE ###
DKSETPATH(${LIBRARY}/${BUILD_DIR})
DKCOMMAND(${DKCMAKE_BUILD} ${LIBRARY})

WIN_VS(${LIBRARY_NAME} library.sln library)
MAC_XCODE(${LIBRARY_NAME} library)
IOS_XCODE(${LIBRARY_NAME} library)
IOSSIM_XCODE(${LIBRARY_NAME} library)
LINUX_DKCOMMAND(make library)
RASPBERRY_DKCOMMAND(make library)
ANDROID_VS(${LIBRARY_NAME} library.sln library)
