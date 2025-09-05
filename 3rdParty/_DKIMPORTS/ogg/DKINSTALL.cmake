#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


# https://github.com/xiph/ogg.git
# https://gitlab.xiph.org/xiph/ogg.git
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)
# https://github.com/xiph/ogg/releases/download/v1.3.5/libogg-1.3.5.zip

### DEPEND ###
dk_depend(msys2)

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${ogg}/include					OGG_INCLUDE_DIR)
dk_include			(${ogg_Config_Dir}/include		OGG_INCLUDE_DIR2)
if(MSVC)
	dk_libDebug		(${ogg_Debug_Dir}/ogg.lib		OGG_LIBRARY_DEBUG		OGG_LIBRARY)
	dk_libRelease	(${ogg_Release_Dir}/ogg.lib		OGG_LIBRARY_RELEASE		OGG_LIBRARY)
else()
	dk_libDebug		(${ogg_Debug_Dir}/libogg.a		OGG_LIBRARY_DEBUG		OGG_LIBRARY)
	dk_libRelease	(${ogg_Release_Dir}/libogg.a	OGG_LIBRARY_RELEASE		OGG_LIBRARY)
endif()

### 3RDPARTY AUTOCONF LINK ###
#dk_set(ogg_CONFIGURE 
#	--with-ogg-includes=${OGG_INCLUDE_DIR} 
#	--with-ogg-libraries=${ogg_Build_Dir}/src/.libs 
#	"CFLAGS=-I${OGG_INCLUDE_DIR2}")

### 3RDPARTY CMAKE LINK ###
dk_set(ogg_CMAKE 
	-DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} 
	-DOGG_LIBRARY=${OGG_LIBRARY} 
	"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" 
	"-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")

### GENERATE ###
#if(Android)
dk_configure(${ogg} 
	-DBUILD_FRAMEWORK=OFF				# "Build Framework bundle for OSX" OFF
	-DINSTALL_CMAKE_PACKAGE_MODULE=ON	# "Install CMake package configuration module" ON
	-DINSTALL_DOCS=OFF					# "Install documentation" ON
	-DINSTALL_PKG_CONFIG_MODULE=ON)		# "Install ogg.pc file" ON
#else()
#	dk_chdir(${ogg_Build_Dir})
#	dk_exec	(${DKCONFIGURE_BUILD})
#endif()

### BUILD ###
dk_build(${ogg})
