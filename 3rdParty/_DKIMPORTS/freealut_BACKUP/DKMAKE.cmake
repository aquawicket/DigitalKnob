# https://github.com/vancegroup/freealut
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)


### IMPORT ###
dk_import(https://github.com/vancegroup/freealut.git)


### LINK ###
dk_define			(AL_LIBTYPE_STATIC)
dk_include			(${FREEALUT}/include)
WIN_dk_libDebug		(${FREEALUT}/${OS}/src/${DEBUG_DIR}/alut_static.lib)
WIN_dk_libRelease	(${FREEALUT}/${OS}/src/${RELEASE_DIR}/alut_static.lib)
UNIX_dk_libDebug	(${FREEALUT}/${OS}/src/${DEBUG_DIR}/libalut_static.a)
UNIX_dk_libRelease	(${FREEALUT}/${OS}/src/${RELEASE_DIR}/libalut_static.a)


### GENERATE ###
dk_setPath				(${FREEALUT}/${BUILD_DIR})
WIN_dk_queueCommand		(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE} "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL}/include/AL /I${MSINTTYPES}" ${FREEALUT})
MAC_dk_queueCommand		(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE} ${FREEALUT})
LINUX_dk_queueCommand	(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE} ${FREEALUT})


### COMPILE ###
dk_visualStudio	(${FREEALUT_NAME} alut_static) # windows, android
dk_xcode		(${FREEALUT_NAME} alut_static) # mac, ios, iossim
dk_make			(${FREEALUT_NAME} alut_static) # linux, raspberry
