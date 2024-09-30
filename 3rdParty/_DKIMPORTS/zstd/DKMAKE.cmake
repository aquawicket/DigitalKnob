#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/facebook/zstd.git
# https://github.com/facebook/folly/blob/main/CMake/FindZstd.cmake

### IMPORT ###
dk_import(https://github.com/facebook/zstd/archive/27bf1362fe10481bfed1f92cc24a9972e702e691.zip)
#dk_import(https://github.com/facebook/zstd/archive/refs/heads/release.zip)



### LINK ###
dk_include					(${ZSTD_DIR}/lib										ZSTD_INCLUDE_DIR)
if(MSVC)
	ANDROID_dk_libDebug		(${ZSTD_CONFIG_DIR}/lib/${DEBUG_DIR}/libzstd.a			Zstd_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${ZSTD_CONFIG_DIR}/lib/${RELEASE_DIR}/libzstd.a		Zstd_LIBRARY_RELEASE)
	WIN_dk_libDebug			(${ZSTD_CONFIG_DIR}/lib/${DEBUG_DIR}/zstd_static.lib	Zstd_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${ZSTD_CONFIG_DIR}/lib/${RELEASE_DIR}/zstd_static.lib	Zstd_LIBRARY_RELEASE)
elseif(APPLE)
	dk_libDebug				(${ZSTD_CONFIG_DIR}/lib/${DEBUG_DIR}/libzstd.a			Zstd_LIBRARY_DEBUG)
	dk_libRelease			(${ZSTD_CONFIG_DIR}/lib/${RELEASE_DIR}/libzstd.a		Zstd_LIBRARY_RELEASE)
else()
	dk_libDebug				(${ZSTD_CONFIG_DIR}/lib/libzstd.a						Zstd_LIBRARY_DEBUG)
	dk_libRelease			(${ZSTD_CONFIG_DIR}/lib/libzstd.a						Zstd_LIBRARY_RELEASE)
endif()
DEBUG_dk_set				(ZSTD_LIBRARY		${Zstd_LIBRARY_DEBUG})
RELEASE_dk_set				(ZSTD_LIBRARY		${Zstd_LIBRARY_RELEASE})
dk_set						(Zstd_LIBRARY		${ZSTD_LIBRARY})
dk_set						(Zstd_LIBRARIES		${Zstd_LIBRARY_DEBUG} ${Zstd_LIBRARY_RELEASE})
dk_set						(Zstd_INCLUDE_DIR	${ZSTD_INCLUDE_DIR})



### 3RDPARTY LINK ###
dk_set(ZSTD_CMAKE
	-DZSTD_INCLUDE_DIR=${ZSTD_INCLUDE_DIR}
	-DZSTD_LIBRARY=${ZSTD_LIBRARY}
	-DZstd_LIBRARY=${Zstd_LIBRARY}
	-DZstd_INCLUDE_DIR=${Zstd_INCLUDE_DIR} 
	-DZstd_LIBRARY_DEBUG=${Zstd_LIBRARY_DEBUG} 
	-DZstd_LIBRARY_RELEASE=${Zstd_LIBRARY_RELEASE} 
	-DZstd_LIBRARIES=${Zstd_LIBRARIES}
	"-DCMAKE_EXE_LINKER_FLAGS=${Zstd_LIBRARIES}")
		
	


### GENERATE ###
dk_configure(${ZSTD_DIR}/build/cmake
	-DZSTD_BUILD_CONTRIB=OFF		# "BUILD CONTRIB" OFF
	-DZSTD_BUILD_PROGRAMS=OFF		# "BUILD PROGRAMS" ON
	-DZSTD_BUILD_SHARED=OFF			# "BUILD SHARED LIBRARIES" ON
	-DZSTD_BUILD_STATIC=ON			# "BUILD STATIC LIBRARIES" ON
	-DZSTD_BUILD_TESTS=OFF			# "BUILD TESTS" ${ZSTD_BUILD_TESTS_default}
	-DZSTD_LEGACY_SUPPORT=OFF		# "LEGACY SUPPORT" OFF
	-DZSTD_MULTITHREAD_SUPPORT=ON	# "MULTITHREADING SUPPORT" ON
	-DZSTD_PROGRAMS_LINK_SHARED=OFF # "PROGRAMS LINK SHARED" OFF
	-DZSTD_USE_STATIC_RUNTIME=ON)	# "LINK TO STATIC RUN-TIME LIBRARIES" OFF


### COMPILE ###
dk_build(${ZSTD_DIR})
