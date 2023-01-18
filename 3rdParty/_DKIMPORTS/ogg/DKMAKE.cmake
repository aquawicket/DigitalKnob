# https://gitlab.xiph.org/xiph/ogg
# https://github.com/xiph/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip
# https://github.com/xiph/ogg.git


### DEPEND ###
WIN_dk_depend(msys)


### IMPORT ###
dk_import(https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)
#dk_import(https://github.com/xiph/ogg.git)


### LINK ###
dk_include				(${OGG}/include)
dk_include				(${OGG}/${OS}/${DEBUG_DIR}/include)
dk_include				(${OGG}/${OS}/${RELEASE_DIR}/include)
ANDROID_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libogg.a)
ANDROID_dk_libRelease	(${OGG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libogg.a)
APPLE_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
APPLE_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
EMSCRIPTEN_dk_libDebug	(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
EMSCRIPTEN_dk_libRelease(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
LINUX_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
LINUX_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
RASPBERRY_dk_libDebug	(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
RASPBERRY_dk_libRelease	(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
WIN_dk_libDebug			(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
WIN_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)


### 3RDPARTY CONFIGURE LINK ###
ANDROID_DEBUG_dk_set		(OGG_CONFIGURE -I${OGG}/${OS}/${DEBUG_DIR}/include 		--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
ANDROID_RELEASE_dk_set		(OGG_CONFIGURE -I${OGG}/${OS}/${RELEASE_DIR}/include 	--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
APPLE_DEBUG_dk_set			(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
APPLE_RELEASE_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
EMSCRIPTEN_DEBUG_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
EMSCRIPTEN_RELEASE_dk_set	(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
LINUX_DEBUG_dk_set			(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
LINUX_RELEASE_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
RASPBERRY_DEBUG_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
RASPBERRY_RELEASE_dk_set	(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
WIN_DEBUG_dk_set			(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
WIN_RELEASE_dk_set			(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)


### 3RDPARTY CMAKE LINK ###
DEBUG_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a 		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" )
RELEASE_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${OGG}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueShell		(${DKCONFIGURE_BUILD})
DEBUG_dk_queueShell		(make)
RELEASE_dk_setPath		(${OGG}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueShell	(make)
