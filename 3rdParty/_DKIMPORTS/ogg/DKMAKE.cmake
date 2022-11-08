# https://gitlab.xiph.org/xiph/ogg
# https://github.com/xiph/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip
# https://github.com/xiph/ogg.git


### DEPEND ###
dk_depend(msys)


### IMPORT ###
dk_import(https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)
#dk_import(https://github.com/xiph/ogg.git)


### LINK ###
dk_include				(${OGG}/include)
dk_include				(${OGG}/${OS}/${DEBUG_DIR}/include)
dk_include				(${OGG}/${OS}/${RELEASE_DIR}/include)
WIN_dk_libDebug			(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
WIN_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
APPLE_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
APPLE_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
LINUX_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
LINUX_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
RASPBERRY_dk_libDebug	(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
RASPBERRY_dk_libRelease	(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
ANDROID_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libogg.a)
ANDROID_dk_libRelease	(${OGG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libogg.a)


### 3RDPARTY CONFIGURE LINK ###
WIN_DEBUG_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
WIN_RELEASE_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
APPLE_DEBUG_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
APPLE_RELEASE_dk_set	(OGG_CONFIGURE --with-ogg-includes=${OGG}/include 		--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
LINUX_DEBUG_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
LINUX_RELEASE_dk_set	(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
RASPBERRY_DEBUG_dk_set	(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
RASPBERRY_RELEASE_dk_set(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
ANDROID_DEBUG_dk_set	(OGG_CONFIGURE -I${OGG}/${OS}/${DEBUG_DIR}/include 		--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)
ANDROID_RELEASE_dk_set	(OGG_CONFIGURE -I${OGG}/${OS}/${RELEASE_DIR}/include 	--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs 	CFLAGS=-I${OGG}/include)

### 3RDPARTY CMAKE LINK ###
WIN_DEBUG_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a 		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" )
WIN_RELEASE_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")
APPLE_DEBUG_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a 		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include")
APPLE_RELEASE_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")
LINUX_DEBUG_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a 		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include")
LINUX_RELEASE_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")
RASPBERRY_DEBUG_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a 		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include")
RASPBERRY_RELEASE_dk_set(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")
ANDROID_DEBUG_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include")
ANDROID_RELEASE_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")


### GENERATE / COMPILE ###
string(REPLACE "--disable-shared" "" GZIP_CONFIGURE "${DKCONFIGURE_BUILD}")
string(REPLACE "--enable-static" "" GZIP_CONFIGURE "${GZIP_CONFIGURE}")
string(REPLACE "  " " " GZIP_CONFIGURE "${GZIP_CONFIGURE}")

WIN_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_queueMsys(${GZIP_CONFIGURE})
WIN_DEBUG_dk_queueMsys(make)
WIN_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_queueMsys(${GZIP_CONFIGURE})
WIN_RELEASE_dk_queueMsys(make)

APPLE_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
APPLE_DEBUG_dk_queueCommand(${GZIP_CONFIGURE})
APPLE_DEBUG_dk_queueCommand(make)
APPLE_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
APPLE_RELEASE_dk_queueCommand(${GZIP_CONFIGURE})
APPLE_RELEASE_dk_queueCommand(make)

LINUX_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${GZIP_CONFIGURE})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${GZIP_CONFIGURE})
LINUX_RELEASE_dk_queueCommand(make)

RASPBERRY_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${GZIP_CONFIGURE})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${GZIP_CONFIGURE})
RASPBERRY_RELEASE_dk_queueCommand(make)

#ANDROID_dk_ndk(${OGG_FOLDER})
ANDROID_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueMsys(${GZIP_CONFIGURE})
ANDROID_DEBUG_dk_queueMsys(make)
ANDROID_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueMsys(${GZIP_CONFIGURE})
ANDROID_RELEASE_dk_queueMsys(make)
