#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

dk_load(dk_builder)
# https://github.com/facebook/zstd.git
# https://github.com/facebook/folly/blob/main/CMake/FindZstd.cmake

### IMPORT ###
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParam("$ENV{DKIMPORTS_DIR}/zstd/dkconfig.txt" ZSTD_DL)
dk_import(${ZSTD_DL})

### LINK ###
dk_include				(${ZSTD_DIR}/lib										ZSTD_INCLUDE_DIR)
if(MSVC)
	if(WIN)
		dk_libDebug		(${ZSTD_CONFIG_DIR}/lib/${DEBUG_DIR}/zstd_static.lib	Zstd_LIBRARY_DEBUG)
		dk_libRelease	(${ZSTD_CONFIG_DIR}/lib/${RELEASE_DIR}/zstd_static.lib	Zstd_LIBRARY_RELEASE)
	else()
		dk_libDebug		(${ZSTD_CONFIG_DIR}/lib/${DEBUG_DIR}/libzstd.a			Zstd_LIBRARY_DEBUG)
		dk_libRelease	(${ZSTD_CONFIG_DIR}/lib/${RELEASE_DIR}/libzstd.a		Zstd_LIBRARY_RELEASE)
	endif()
elseif(APPLE)
	dk_libDebug			(${ZSTD_CONFIG_DIR}/lib/${DEBUG_DIR}/libzstd.a			Zstd_LIBRARY_DEBUG)
	dk_libRelease		(${ZSTD_CONFIG_DIR}/lib/${RELEASE_DIR}/libzstd.a		Zstd_LIBRARY_RELEASE)
else()
	dk_libDebug			(${ZSTD_CONFIG_DIR}/lib/libzstd.a						Zstd_LIBRARY_DEBUG)
	dk_libRelease		(${ZSTD_CONFIG_DIR}/lib/libzstd.a						Zstd_LIBRARY_RELEASE)
endif()
if(DEBUG)
	dk_set				(ZSTD_LIBRARY		${Zstd_LIBRARY_DEBUG})
endif()
if(RELEASE)
	dk_set				(ZSTD_LIBRARY		${Zstd_LIBRARY_RELEASE})
endif()
dk_set					(Zstd_LIBRARY		${ZSTD_LIBRARY})
dk_set					(Zstd_LIBRARIES		${Zstd_LIBRARY_DEBUG} ${Zstd_LIBRARY_RELEASE})
dk_set					(Zstd_INCLUDE_DIR	${ZSTD_INCLUDE_DIR})

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
