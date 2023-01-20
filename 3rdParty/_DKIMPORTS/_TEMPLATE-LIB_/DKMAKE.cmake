# to use this template, remove these lines
dk_undepend(_TEMPLATE-LIB_)
dk_return()
#########################################

# https://github.com/organization/package


### DEPENDS ###
#dk_depend(libname)


### INSTALL ###
#dk_import(https://organization.com/download/package-1.0.zip)
dk_import(https://github.com/organization/package.git)


### LINK ###
dk_include			(${PACKAGE}/include)
UNIX_dk_libDebug	(${PACKAGE}/${OS}/${DEBUG_DIR}/libpackage.a)
UNIX_dk_libRelease	(${PACKAGE}/${OS}/${RELEASE_DIR}/libpackage.a)
WIN_dk_libDebug		(${PACKAGE}/${OS}/${DEBUG_DIR}/package.lib)
WIN_dk_libRelease	(${PACKAGE}/${OS}/${RELEASE_DIR}/package.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${PACKAGE})


### COMPILE ###
dk_build(${PACKAGE} package)
