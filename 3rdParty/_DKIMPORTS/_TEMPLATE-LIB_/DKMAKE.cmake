# https://github.com/name/library
#
# http://www.library.com/downloads/library-1.0.0.zip


### DEPENDS ###
#DKDEPEND(depend_name)


### DOWNLOAD ###
DKIMPORT(https://github.com/name/library.git)
#DKIMPORT(https://github.com/name/library/releases/download/1.0.0/library-1.0.0.zip)


### LINK ###
DKINCLUDE(${LIBRARY}/include)
WIN_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/library.lib)
WIN_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/library.lib)
UNIX_DEBUG_DKLIB(${LIBRARY}/${OS}/${DEBUG_DIR}/liblibrary.a)
UNIX_RELEASE_DKLIB(${LIBRARY}/${OS}/${RELEASE_DIR}/liblibrary.a)


### GENERATE ###
DKSETPATH(${LIBRARY}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${LIBRARY})


### COMPILE ###
WIN_VS(${LIBRARY_NAME} library.sln library)
MAC_XCODE(${LIBRARY_NAME} library)
IOS_XCODE(${LIBRARY_NAME} library)
IOSSIM_XCODE(${LIBRARY_NAME} library)
LINUX_DKQCOMMAND(make library)
RASPBERRY_DKQCOMMAND(make library)
ANDROID_VS(${LIBRARY_NAME} library.sln library)
