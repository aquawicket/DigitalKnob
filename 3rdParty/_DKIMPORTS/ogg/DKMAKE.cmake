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
if(MULTI_CONFIG)
	dk_include				(${OGG}/${OS}/include											OGG_INCLUDE_DIR2)
else()
	DEBUG_dk_include		(${OGG}/${OS}/${DEBUG_DIR}/include								OGG_INCLUDE_DIR2)
	RELEASE_dk_include		(${OGG}/${OS}/${RELEASE_DIR}/include							OGG_INCLUDE_DIR2)
endif()

if(ANDROID)
	ANDROID_dk_libDebug		(${OGG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libogg.a		OGG_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${OGG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libogg.a		OGG_LIBRARY_RELEASE)
else()
	dk_libDebug				(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a					OGG_LIBRARY_DEBUG)
	dk_libRelease			(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a					OGG_LIBRARY_RELEASE)
endif()



### 3RDPARTY CONFIGURE LINK ###
#DEBUG_dk_set		(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}	-I${OGG_INCLUDE_DIR2} --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_LIBRARY_DEBUG})
#RELEASE_dk_set		(OGG_CONFIGURE CFLAGS=-I${OGG_INCLUDE_DIR}	-I${OGG_INCLUDE_DIR2} --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_LIBRARY_RELEASE})
DEBUG_dk_set		(OGG_CONFIGURE CFLAGS=--with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_LIBRARY_DEBUG})
RELEASE_dk_set		(OGG_CONFIGURE CFLAGS=--with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_LIBRARY_RELEASE})


### 3RDPARTY CMAKE LINK ###
DEBUG_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_DEBUG} 	 "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")
RELEASE_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_RELEASE} "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${OGG}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
DEBUG_dk_queueCommand	(make)

RELEASE_dk_setPath		(${OGG}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueCommand	(make)
