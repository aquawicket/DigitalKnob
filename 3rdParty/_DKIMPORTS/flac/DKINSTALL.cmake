#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ flac ############
# https://github.com/xiph/flac.git
# https://ftp.osuosl.org/pub/xiph/releases/flac
# https://github.com/xiph/flac/releases/download/1.4.3/flac-1.4.3.tar.xz

dk_validate(nasm "dk_depend(nasm)")
dk_depend(ogg)


dk_import()


### LINK ###
dk_include			(${flac}/include												FLAC_INCLUDE_DIR)

if(MSVC)
	#dk_libDebug	(${flac_Config_Dir}/src/libFLAC/${Debug_Dir}/FLAC.lib			FLAC_LIBRARY_DEBUG		FLAC_LIBRARY)
	#dk_libRelease	(${flac_Config_Dir}/src/libFLAC/${Release_Dir}/FLAC.lib			FLAC_LIBRARY_RELEASE	FLAC_LIBRARY)
	dk_libDebug		(${flac_Config_Dir}/src/libFLAC++/${Debug_Dir}/FLAC++.lib		FLAC_LIBRARY_DEBUG		FLAC_LIBRARY)
	dk_libRelease	(${flac_Config_Dir}/src/libFLAC++/${Release_Dir}/FLAC++.lib		FLAC_LIBRARY_RELEASE	FLAC_LIBRARY)
else()
	#dk_libDebug	(${flac_Debug_Dir}/src/libFLAC/libFLAC.a						FLAC_LIBRARY_DEBUG		FLAC_LIBRARY)
	#dk_libRelease	(${flac_Release_Dir}/src/libFLAC/libFLAC.a						FLAC_LIBRARY_RELEASE	FLAC_LIBRARY)
	dk_libDebug		(${flac_Debug_Dir}/src/libFLAC++/libFLAC++.a					FLAC_LIBRARY_DEBUG		FLAC_LIBRARY)
	dk_libRelease	(${flac_Release_Dir}/src/libFLAC++/libFLAC++.a					FLAC_LIBRARY_RELEASE	FLAC_LIBRARY)
endif()


dk_set(flac_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
	-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_DIR}
	-DFLAC_LIBRARY=${FLAC_LIBRARY}
	-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG}
	-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE}
	"-DCMAKE_C_FLAGS=-I${FLAC_INCLUDE_DIR}"
	"-DCMAKE_CXX_FLAGS=-I${FLAC_INCLUDE_DIR}")


dk_configure(${flac}
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
	${ogg_CMAKE})



### BUILD ###
dk_build()

