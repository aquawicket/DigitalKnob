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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/xiph/ogg.git
# https://gitlab.xiph.org/xiph/ogg.git
# https://ftp.osuosl.org/pub/xiph/releases/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)

### DEPEND ###
if(Windows)
	dk_validate(msys2 "dk_depend(msys2)")
endif()

### IMPORT ###
#dk_import(https://github.com/xiph/ogg.git)
dk_import(https://github.com/xiph/ogg/releases/download/v1.3.5/libogg-1.3.5.zip)


### LINK ###
dk_include			(${OGG}/include				OGG_INCLUDE_DIR)
dk_include			(${OGG_Config_Dir}/include		OGG_INCLUDE_DIR2)
if(MSVC)
	dk_libDebug		(${OGG_Debug_Dir}/ogg.lib		OGG_LIBRARY_DEBUG)
	dk_libRelease	(${OGG_Release_Dir}/ogg.lib		OGG_LIBRARY_RELEASE)
else()
	dk_libDebug		(${OGG_Debug_Dir}/libogg.a		OGG_LIBRARY_DEBUG)
	dk_libRelease	(${OGG_Release_Dir}/libogg.a	OGG_LIBRARY_RELEASE)
endif()


### 3RDPARTY AUTOCONF LINK ###
#Debug_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_Debug_Dir}/src/.libs		"CFLAGS=-I${OGG_INCLUDE_DIR2}")
#Release_dk_set		(OGG_CONFIGURE --with-ogg-includes=${OGG_INCLUDE_DIR} --with-ogg-libraries=${OGG_Release_Dir}/src/.libs	"CFLAGS=-I${OGG_INCLUDE_DIR2}")

### 3RDPARTY CMAKE LINK ###
if(Debug)
	dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_DEBUG}		"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")
endif()
if(Release)
	dk_set	(OGG_CMAKE -DOGG_INCLUDE_DIR=${OGG_INCLUDE_DIR} -DOGG_LIBRARY=${OGG_LIBRARY_RELEASE}	"-DCMAKE_C_FLAGS=-I${OGG_INCLUDE_DIR2}" "-DCMAKE_CXX_FLAGS=-I${OGG_INCLUDE_DIR2}")
endif()

### GENERATE ###
#if(Android)
dk_configure(${OGG} 
	-DBUILD_FRAMEWORK=OFF				# "Build Framework bundle for OSX" OFF
	-DINSTALL_CMAKE_PACKAGE_MODULE=ON	# "Install CMake package configuration module" ON
	-DINSTALL_DOCS=OFF					# "Install documentation" ON
	-DINSTALL_PKG_CONFIG_MODULE=ON)		# "Install ogg.pc file" ON

#else()
#	DEBUG_dk_chdir			(${OGG_Debug_Dir})
#	DEBUG_dk_exec			(${DKCONFIGURE_BUILD})
#	RELEASE_dk_chdir		(${OGG_Release_Dir})
#	RELEASE_dk_exec			(${DKCONFIGURE_BUILD})
#endif()


### BUILD ###
dk_build			(${OGG})

