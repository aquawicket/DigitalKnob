#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp


### DEPEND ###
if(IOS OR IOSSIM)
	#dk_depend(libmd)
	#dk_depend(macports)
endif()


### IMPORT ###
if(UNIX)
	dk_import		(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
elseif(MINGW)
	dk_import	(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
elseif(WIN)
	dk_import	(https://github.com/weidai11/cryptopp/archive/60f81a77e0c9a0e7ffc1ca1bc438ddfa2e43b78e.zip)
	#dk_import	(https://github.com/weidai11/cryptopp/archive/refs/heads/master.zip)
endif()


### LINK ###
if(ANDROID)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(APPLE)
	dk_libDebug		(${CRYPTOPP_TRIPLE_DIR}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
	dk_libRelease	(${CRYPTOPP_TRIPLE_DIR}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
elseif(EMSCRIPTEN)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(LINUX)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(RASPBERRY)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(MSVC)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/cryptopp-static.lib)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/cryptopp-static.lib)
elseif(WIN)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
endif()


### GENERATE ###
if(ANDROID OR MAC)
	dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
	string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\""	"" DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-std=c++1z" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-DMAC " " " 	DKCMAKE_BUILD "${DKCMAKE_BUILD}") #fix for class named MAC in cryptopp
	string(REPLACE "  " 		" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()

if(ANDROID)
	dk_configure		(${CRYPTOPP_DIR} "-DCMAKE_CXX_FLAGS=/I${ANDROID_NDK}/sources/android/cpufeatures" -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(EMSCRIPTEN)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(IOS)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} ${LIBMD_CMAKE})
elseif(IOSSIM)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} ${LIBMD_CMAKE})
elseif(LINUX)	
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(MAC)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} -DCRYPTOPP_DISABLE_MIXED_ASM=ON)
elseif(RASPBERRY)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(WIN)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
endif()

### COMPILE ###
dk_build(${CRYPTOPP} cryptopp-static)
