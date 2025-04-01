#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/xiph/flac.git
# https://ftp.osuosl.org/pub/xiph/releases/flac


### DEPEND ###
dk_depend(nasm)
dk_depend(ogg)


### IMPORT ###
#dk_import(https://github.com/xiph/flac.git)
dk_import(https://github.com/xiph/flac/releases/download/1.4.3/flac-1.4.3.tar.xz)


### LINK ###
dk_include				(${FLAC}/include											FLAC_INCLUDE_DIR)

if(MSVC)
	#dk_libDebug	(${FLAC_CONFIG_DIR}/src/libFLAC/${DEBUG_DIR}/FLAC.lib			FLAC_LIBRARY_DEBUG)
	#dk_libRelease	(${FLAC_CONFIG_DIR}/src/libFLAC/${RELEASE_DIR}/FLAC.lib			FLAC_LIBRARY_RELEASE)
	dk_libDebug		(${FLAC_CONFIG_DIR}/src/libFLAC++/${DEBUG_DIR}/FLAC++.lib		FLAC_LIBRARY_DEBUG)
	dk_libRelease	(${FLAC_CONFIG_DIR}/src/libFLAC++/${RELEASE_DIR}/FLAC++.lib		FLAC_LIBRARY_RELEASE)
else()
	#dk_libDebug	(${FLAC_DEBUG_DIR}/src/libFLAC/libFLAC.a						FLAC_LIBRARY_DEBUG)
	#dk_libRelease	(${FLAC_RELEASE_DIR}/src/libFLAC/libFLAC.a						FLAC_LIBRARY_RELEASE)
	dk_libDebug		(${FLAC_DEBUG_DIR}/src/libFLAC++/libFLAC++.a					FLAC_LIBRARY_DEBUG)
	dk_libRelease	(${FLAC_RELEASE_DIR}/src/libFLAC++/libFLAC++.a					FLAC_LIBRARY_RELEASE)
endif()
set(FLAC_INCLUDE_PATH	${FLAC_INCLUDE_DIR})
if(DEBUG)
	set(FLAC_LIBRARY	${FLAC_LIBRARY_DEBUG})
elseif(RELEASE)
	set(FLAC_LIBRARY	${FLAC_LIBRARY_RELEASE})
endif()


### 3rd Party Link ###
dk_set(FLAC_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
	-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_PATH}
	-DFLAC_LIBRARY=${FLAC_LIBRARY}
	-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG}
	-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE}
	"-DCMAKE_C_FLAGS=-I${FLAC_INCLUDE_DIR}"
	"-DCMAKE_CXX_FLAGS=-I${FLAC_INCLUDE_DIR}")




### GENERATE ###
dk_configure(${FLAC_DIR}
	-DBUILD_CXXLIBS=ON 					# "Build libFLAC++" ON
	-DBUILD_PROGRAMS=ON					# "Build and install programs" ON
	-DBUILD_EXAMPLES=ON					# "Build and install examples" ON
	-DBUILD_TESTING=ON					# "Build tests" ON
	-DBUILD_DOCS=ON						# "Build and install doxygen documents" ON
	-DWITH_FORTIFY_SOURCE=ON 			# "Enable protection against buffer overflows" ON
	-DWITH_STACK_PROTECTOR=ON			# "Enable GNU GCC stack smash protection" ON
	-DINSTALL_MANPAGES=ON				# "Install MAN pages" ON
	-DINSTALL_PKGCONFIG_MODULES=ON 		# "Install PkgConfig modules" ON
	-DINSTALL_CMAKE_CONFIG_MODULE=ON	# "Install CMake package-config module" ON
	-DWITH_OGG=ON						# "ogg support (default: test for libogg)" ON
	#-DBUILD_SHARED_LIBS=OFF			# "Build shared instead of static libraries" OFF
	${OGG_CMAKE})



### BUILD ###
dk_build(${FLAC_DIR})

