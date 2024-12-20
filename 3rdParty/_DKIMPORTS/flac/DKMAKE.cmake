#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


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
dk_include			(${FLAC}/include												FLAC_INCLUDE_DIR)

if(MULTI_CONFIG)
	if(MSVC)
		dk_libDebug		(${FLAC_CONFIG_DIR}/src/libFLAC/${DEBUG_DIR}/FLAC.lib		FLAC_LIBRARY_DEBUG)
		dk_libRelease	(${FLAC_CONFIG_DIR}/src/libFLAC/${RELEASE_DIR}/FLAC.lib		FLAC_LIBRARY_RELEASE)

	endif()
else()
	dk_libDebug		(${FLAC_DEBUG_DIR}/src/libFLAC/libFLAC.a			FLAC_LIBRARY_DEBUG)
	dk_libRelease	(${FLAC_RELEASE_DIR}/src/libFLAC/libFLAC.a			FLAC_LIBRARY_RELEASE)
endif()


### 3rd Party Link ###
if(MULTI_CONFIG)
	dk_set(FLAC_CMAKE
		-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
		-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
		-DFLAC_LIBRARY=${FLAC_LIBRARY_DEBUG}
		-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG}
		-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE}
		"-DCMAKE_C_FLAGS=-I${FLAC_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=-I${FLAC_INCLUDE_DIR}")
else()
	if(DEBUG)
		dk_set(FLAC_CMAKE 
			-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
			-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
			-DFLAC_LIBRARY=${FLAC_LIBRARY_DEBUG}
			-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG}
			"-DCMAKE_C_FLAGS=-I${FLAC_INCLUDE_DIR}"
			"-DCMAKE_CXX_FLAGS=-I${FLAC_INCLUDE_DIR}")
	endif()
	if(RELEASE)
		dk_set(FLAC_CMAKE 
			-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
			-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
			-DFLAC_LIBRARY=${FLAC_LIBRARY_RELEASE}
			-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE}
			"-DCMAKE_C_FLAGS=-I${FLAC_INCLUDE_DIR}"
			"-DCMAKE_CXX_FLAGS=-I${FLAC_INCLUDE_DIR}")
	endif()
endif()



### GENERATE ###
dk_configure(${FLAC_DIR}
	-DBUILD_CXXLIBS=ON					# "Build libFLAC++" ON
	-DBUILD_DOCS=OFF					# "Build and install doxygen documents" ON
	-DBUILD_EXAMPLES=OFF				# "Build and install examples" ON
	-DBUILD_PROGRAMS=OFF 				# "Build and install programs" ON
	-DINSTALL_CMAKE_CONFIG_MODULE=ON	# "Install CMake package-config module" ON
	-DINSTALL_MANPAGES=OFF				# "Install MAN pages" ON
	-DINSTALL_PKGCONFIG_MODULES=ON		# "Install PkgConfig modules" ON
	-DWITH_FORTIFY_SOURCE=ON			# "Enable protection against buffer overflows" ON
	-DWITH_OGG=ON						# "ogg support (default: test for libogg)" ON
	-DWITH_STACK_PROTECTOR=ON			# "Enable GNU GCC stack smash protection" ON
	${OGG_CMAKE})



### BUILD ###
dk_build(${FLAC_DIR})

