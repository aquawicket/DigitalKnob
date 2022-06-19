# https://github.com/organization/package


### DEPENDS ###
#dk_depend(libname)


### DOWNLOAD ###
dk_import(https://github.com/organization/package.git)
#dk_import(https://organization.com/download/package-1.0.zip)


### LINK ###
dk_include(${PACKAGE}/include)
WIN_dk_libDebug(${PACKAGE}/${OS}/${DEBUG_DIR}/package.lib)
WIN_dk_libRelease(${PACKAGE}/${OS}/${RELEASE_DIR}/package.lib)
UNIX_dk_libDebug(${PACKAGE}/${OS}/${DEBUG_DIR}/libpackage.a)
UNIX_dk_libRelease(${PACKAGE}/${OS}/${RELEASE_DIR}/libpackage.a)


### GENERATE ###
dk_setPath(${PACKAGE}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${PACKAGE})


### COMPILE ###
VISUAL_STUDIO(${PACKAGE_NAME} package.sln package)  # WIN_dk_visualStudio(), ANDROID_dk_visualStudio()
dk_xcode(${PACKAGE_NAME} package) 						# MAC_dk_xcode(), IOS_XCODE, IOSSIM_dk_xcode()
MAKE(package) 										# LINUX_dk_queueCommand(make), RASPBERRY_dk_queueCommand(make)