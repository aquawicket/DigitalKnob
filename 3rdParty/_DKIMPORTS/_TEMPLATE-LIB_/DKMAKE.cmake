# https://github.com/organization/package


### DEPENDS ###
#dk_depend(libname)


### DOWNLOAD ###
dk_import(https://github.com/organization/package.git)
#dk_import(https://organization.com/download/package-1.0.zip)


### LINK ###
dk_include(${PACKAGE}/include)
WIN_DEBUG_DKLIB(${PACKAGE}/${OS}/${DEBUG_DIR}/package.lib)
WIN_RELEASE_DKLIB(${PACKAGE}/${OS}/${RELEASE_DIR}/package.lib)
UNIX_DEBUG_DKLIB(${PACKAGE}/${OS}/${DEBUG_DIR}/libpackage.a)
UNIX_RELEASE_DKLIB(${PACKAGE}/${OS}/${RELEASE_DIR}/libpackage.a)


### GENERATE ###
dk_setPath(${PACKAGE}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${PACKAGE})


### COMPILE ###
VISUAL_STUDIO(${PACKAGE_NAME} package.sln package)  # WIN_dk_VisualStudio(), ANDROID_dk_VisualStudio()
XCODE(${PACKAGE_NAME} package) 						# MAC_XCODE(), IOS_XCODE, IOSSIM_XCODE()
MAKE(package) 										# LINUX_dk_queueCommand(make), RASPBERRY_dk_queueCommand(make)