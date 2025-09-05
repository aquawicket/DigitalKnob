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
	#dk_libDebug	(${FLAC_Config_Dir}/src/libFLAC/${Debug_Dir}/FLAC.lib			FLAC_LIBRARY_DEBUG)
	#dk_libRelease	(${FLAC_Config_Dir}/src/libFLAC/${Release_Dir}/FLAC.lib			FLAC_LIBRARY_RELEASE)
	dk_libDebug		(${FLAC_Config_Dir}/src/libFLAC++/${Debug_Dir}/FLAC++.lib		FLAC_LIBRARY_DEBUG)
	dk_libRelease	(${FLAC_Config_Dir}/src/libFLAC++/${Release_Dir}/FLAC++.lib		FLAC_LIBRARY_RELEASE)
else()
	#dk_libDebug	(${FLAC_Debug_Dir}/src/libFLAC/libFLAC.a						FLAC_LIBRARY_DEBUG)
	#dk_libRelease	(${FLAC_Release_Dir}/src/libFLAC/libFLAC.a						FLAC_LIBRARY_RELEASE)
	dk_libDebug		(${FLAC_Debug_Dir}/src/libFLAC++/libFLAC++.a					FLAC_LIBRARY_DEBUG)
	dk_libRelease	(${FLAC_Release_Dir}/src/libFLAC++/libFLAC++.a					FLAC_LIBRARY_RELEASE)
endif()
set(FLAC_INCLUDE_PATH	${FLAC_INCLUDE_DIR})
if(Debug)
	set(FLAC_LIBRARY	${FLAC_LIBRARY_DEBUG})
elseif(Release)
	set(FLAC_LIBRARY	${FLAC_LIBRARY_RELEASE})
endif()


### 3rd Party Link ###
dk_set(flac_CMAKE
	-DFLAC_INCLUDE_DIR=${FLAC_INCLUDE_DIR}
	-DFLAC_INCLUDE_PATH=${FLAC_INCLUDE_PATH}
	-DFLAC_LIBRARY=${FLAC_LIBRARY}
	-DFLAC_LIBRARY_DEBUG=${FLAC_LIBRARY_DEBUG}
	-DFLAC_LIBRARY_RELEASE=${FLAC_LIBRARY_RELEASE}
	"-DCMAKE_C_FLAGS=-I${FLAC_INCLUDE_DIR}"
	"-DCMAKE_CXX_FLAGS=-I${FLAC_INCLUDE_DIR}")




### GENERATE ###
dk_configure(${FLAC}
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

