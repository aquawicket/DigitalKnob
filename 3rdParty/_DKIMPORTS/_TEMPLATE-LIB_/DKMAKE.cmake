# https://github.com/organization/package


### DEPENDS ###
#DKDEPEND(libname)


### DOWNLOAD ###
DKIMPORT(https://github.com/organization/package.git)
#DKIMPORT(https://organization.com/download/package-1.0.zip)


### LINK ###
DKINCLUDE(${PACKAGE}/include)
WIN_DEBUG_DKLIB(${PACKAGE}/${OS}/${DEBUG_DIR}/package.lib)
WIN_RELEASE_DKLIB(${PACKAGE}/${OS}/${RELEASE_DIR}/package.lib)
UNIX_DEBUG_DKLIB(${PACKAGE}/${OS}/${DEBUG_DIR}/libpackage.a)
UNIX_RELEASE_DKLIB(${PACKAGE}/${OS}/${RELEASE_DIR}/libpackage.a)


### GENERATE ###
DKSETPATH(${PACKAGE}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${PACKAGE})


### COMPILE ###
VISUAL_STUDIO(${PACKAGE_NAME} package.sln package)  # WIN_VS(), ANDROID_VS()
XCODE(${PACKAGE_NAME} package) 						# MAC_XCODE(), IOS_XCODE, IOSSIM_XCODE()
MAKE(package) 										# LINUX_DKQCOMMAND(make), RASPBERRY_DKQCOMMAND(make)