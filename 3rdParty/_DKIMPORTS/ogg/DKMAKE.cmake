# https://gitlab.xiph.org/xiph/ogg
# https://github.com/xiph/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip
# https://github.com/xiph/ogg.git


### DEPEND ###
WIN_dk_depend(msys2)


### IMPORT ###
dk_import(https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)
#dk_import(https://github.com/xiph/ogg.git)


### LINK ###
dk_include					(${OGG}/include													OGG_INCLUDE_DIR)
dk_include					(${OGG}/${OS}/${DEBUG_DIR}/include								OGG_INCLUDE_DIR_DEBUG)
dk_include					(${OGG}/${OS}/${RELEASE_DIR}/include							OGG_INCLUDE_DIR_RELEASE)
ANDROID_dk_libDebug			(${OGG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libogg.a		OGG_LIBRARY_DEBUG)
ANDROID_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libogg.a		OGG_LIBRARY_RELEASE)
APPLE_dk_libDebug			(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a					OGG_LIBRARY_DEBUG)
APPLE_dk_libRelease			(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a					OGG_LIBRARY_RELEASE)
EMSCRIPTEN_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a					OGG_LIBRARY_DEBUG)
EMSCRIPTEN_dk_libRelease	(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a					OGG_LIBRARY_RELEASE)
LINUX_dk_libDebug			(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a					OGG_LIBRARY_DEBUG)
LINUX_dk_libRelease			(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a					OGG_LIBRARY_RELEASE)
RASPBERRY_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a					OGG_LIBRARY_DEBUG)
RASPBERRY_dk_libRelease		(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a					OGG_LIBRARY_RELEASE)
WIN_dk_libDebug				(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a					OGG_LIBRARY_DEBUG)
WIN_dk_libRelease			(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a					OGG_LIBRARY_RELEASE)


### 3RDPARTY CONFIGURE LINK ###
ANDROID_DEBUG_dk_set		(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}				-I${OGG_INCLUDE_DIR_DEBUG} 				--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
ANDROID_RELEASE_dk_set		(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}				-I${OGG_INCLUDE_DIR_RELEASE} 			--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
APPLE_DEBUG_dk_set			(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}				--with-ogg-includes=${OGG_INCLUDE_DIR} 	--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
APPLE_RELEASE_dk_set		(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}				--with-ogg-includes=${OGG_INCLUDE_DIR} 	--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
WIN_DEBUG_dk_set			(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}				--with-ogg-includes=${OGG_INCLUDE_DIR} 	--with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
WIN_RELEASE_dk_set			(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}				--with-ogg-includes=${OGG_INCLUDE_DIR} 	--with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
EMSCRIPTEN_DEBUG_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG_INCLUDE_DIR_DEBUG})
EMSCRIPTEN_RELEASE_dk_set	(OGG_CONFIGURE CPPFLAGS=-I${OGG_INCLUDE_DIR_RELEASE})
LINUX_DEBUG_dk_set			(OGG_CONFIGURE CPPFLAGS=-I${OGG_INCLUDE_DIR_DEBUG})
LINUX_RELEASE_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG_INCLUDE_DIR_RELEASE})
RASPBERRY_DEBUG_dk_set		(OGG_CONFIGURE CPPFLAGS=-I${OGG_INCLUDE_DIR_DEBUG})
RASPBERRY_RELEASE_dk_set	(OGG_CONFIGURE CPPFLAGS=-I${OGG_INCLUDE_DIR_RELEASE})



### 3RDPARTY CMAKE LINK ###
DEBUG_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_DEBUG} 		"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" )
RELEASE_dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_RELEASE} 	"-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include")


### GENERATE / COMPILE ###
if(WIN_HOST)
	DEBUG_dk_setPath		(${OGG}/${OS}/${DEBUG_DIR})
	DEBUG_dk_queueMsys2		(${DKCONFIGURE_BUILD})
	DEBUG_dk_queueMsys2		(make)
	RELEASE_dk_setPath		(${OGG}/${OS}/${RELEASE_DIR})
	RELEASE_dk_queueMsys2	(${DKCONFIGURE_BUILD})
	RELEASE_dk_queueMsys2	(make)
else()
	DEBUG_dk_setPath		(${OGG}/${OS}/${DEBUG_DIR})
	DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
	DEBUG_dk_queueCommand	(make)
	RELEASE_dk_setPath		(${OGG}/${OS}/${RELEASE_DIR})
	RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
	RELEASE_dk_queueCommand	(make)
endif()
