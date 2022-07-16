# https://github.com/organization/package


### DEPENDS ###
#dk_depend(libname)


### INSTALL ###
#dk_import	(https://organization.com/download/package-1.0.zip)
dk_import	(https://github.com/organization/package.git)


### LINK ###
dk_include			(${PACKAGE}/include)
WIN_dk_libDebug		(${PACKAGE}/${OS}/${DEBUG_DIR}/package.lib)
WIN_dk_libRelease	(${PACKAGE}/${OS}/${RELEASE_DIR}/package.lib)
UNIX_dk_libDebug	(${PACKAGE}/${OS}/${DEBUG_DIR}/libpackage.a)
UNIX_dk_libRelease	(${PACKAGE}/${OS}/${RELEASE_DIR}/libpackage.a)


### GENERATE ###
dk_setPath		(${PACKAGE}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${PACKAGE})


### COMPILE ###
dk_visualStudio (${PACKAGE_NAME} package) # WIN_dk_visualStudio(), ANDROID_dk_visualStudio()
dk_xcode		(${PACKAGE_NAME} package) # MAC_dk_xcode(), IOS_dk_xcode(), IOSSIM_dk_xcode()
dk_make			(${PACKAGE_NAME} package) # LINUX_dk_queueCommand(make), RASPBERRY_dk_queueCommand(make)