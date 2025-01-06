#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/xiph/ogg.git
# https://gitlab.xiph.org/xiph/ogg.git
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)

### DEPEND ###
if(WIN)
	dk_validate(MSYS2 "dk_depend(msys2)")
endif()

### IMPORT ###
#dk_import(https://github.com/xiph/ogg.git)
dk_import(https://github.com/xiph/ogg/releases/download/v1.3.5/libogg-1.3.5.zip)


### LINK ###
dk_include			(${OGG_DIR}/include				OGG_INCLUDE_DIR)
dk_include			(${OGG_CONFIG_DIR}/include		OGG_INCLUDE_DIR2)
if(MSVC)
	dk_libDebug		(${OGG_DEBUG_DIR}/ogg.lib		OGG_LIBRARY_DEBUG)
	dk_libRelease	(${OGG_RELEASE_DIR}/ogg.lib		OGG_LIBRARY_RELEASE)
else()
	dk_libDebug		(${OGG_DEBUG_DIR}/libogg.a		OGG_LIBRARY_DEBUG)
	dk_libRelease	(${OGG_RELEASE_DIR}/libogg.a	OGG_LIBRARY_RELEASE)
endif()


### 3RDPARTY AUTOCONF LINK ###
#DEBUG_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_DEBUG_DIR}/src/.libs		"CFLAGS=-I${OGG_INCLUDE_DIR2}")
#RELEASE_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_RELEASE_DIR}/src/.libs	"CFLAGS=-I${OGG_INCLUDE_DIR2}")

### 3RDPARTY CMAKE LINK ###
if(DEBUG)
	dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_DEBUG}		"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")
endif()
if(RELEASE)
	dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_RELEASE}	"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")
endif()

### GENERATE ###
#if(ANDROID)
dk_configure(${OGG_DIR} 
	-DBUILD_FRAMEWORK=OFF				# "Build Framework bundle for OSX" OFF
	-DINSTALL_CMAKE_PACKAGE_MODULE=ON	# "Install CMake package configuration module" ON
	-DINSTALL_DOCS=OFF					# "Install documentation" ON
	-DINSTALL_PKG_CONFIG_MODULE=ON)		# "Install ogg.pc file" ON

#else()
#	DEBUG_dk_cd		(${OGG_DEBUG_DIR})
#	DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#	RELEASE_dk_cd		(${OGG_RELEASE_DIR})
#	RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
#endif()


### BUILD ###
dk_build			(${OGG_DIR})

