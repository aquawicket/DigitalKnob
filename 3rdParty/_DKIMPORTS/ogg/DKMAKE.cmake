# https://github.com/xiph/ogg.git
# https://gitlab.xiph.org/xiph/ogg.git
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies


### DEPEND ###
WIN_dk_depend(msys2)


### IMPORT ###
#dk_import(https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)
#dk_import(https://github.com/xiph/ogg.git)
dk_import(https://github.com/xiph/ogg/releases/download/v1.3.5/libogg-1.3.5.zip)


### LINK ###
dk_include					(${OGG}/include									OGG_INCLUDE_DIR)
if(MULTI_CONFIG)
	dk_include				(${OGG}/${OS}/include							OGG_INCLUDE_DIR2)
else()
	DEBUG_dk_include		(${OGG}/${OS}/${DEBUG_DIR}/include				OGG_INCLUDE_DIR2)
	RELEASE_dk_include		(${OGG}/${OS}/${RELEASE_DIR}/include			OGG_INCLUDE_DIR2)
endif()

#if(ANDROID)
	dk_libDebug				(${OGG}/${OS}/${DEBUG_DIR}/libogg.a				OGG_LIBRARY_DEBUG)
	dk_libRelease			(${OGG}/${OS}/${RELEASE_DIR}/libogg.a			OGG_LIBRARY_RELEASE)
#else()
#	dk_libDebug				(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a	OGG_LIBRARY_DEBUG)
#	dk_libRelease			(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a	OGG_LIBRARY_RELEASE)
#endif()



### 3RDPARTY AUTOCONF LINK ###
#DEBUG_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs		"CFLAGS=-I${OGG_INCLUDE_DIR2}")
#RELEASE_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs	"CFLAGS=-I${OGG_INCLUDE_DIR2}")

### 3RDPARTY CMAKE LINK ###
DEBUG_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_DEBUG}		"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")
RELEASE_dk_set		(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_RELEASE}	"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")


### GENERATE ###
#if(ANDROID)
	dk_queueCommand(${DKCMAKE_BUILD} 
					-DBUILD_FRAMEWORK=OFF				# "Build Framework bundle for OSX" OFF
					#-DBUILD_SHARED_LIBS=OFF			# "Build shared library" OFF
					-DBUILD_TESTING=OFF				
					-DINSTALL_CMAKE_PACKAGE_MODULE=ON	# "Install CMake package configuration module" ON
					-DINSTALL_DOCS=OFF					# "Install documentation" ON
					-DINSTALL_PKG_CONFIG_MODULE=ON		# "Install ogg.pc file" ON
					${OGG})
#else()
#	DEBUG_dk_setPath		(${OGG}/${OS}/${DEBUG_DIR})
#	DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#	RELEASE_dk_setPath		(${OGG}/${OS}/${RELEASE_DIR})
#	RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
#endif()


### BUILD ###
dk_build			(${OGG})

