#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp


### DEPEND ###
if(IOS OR Iossim)
	#dk_depend(libmd)
	#dk_depend(macports)
endif()


### IMPORT ###
if(Unix)
	dk_import		(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
elseif(MINGW)
	dk_import	(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
elseif(Windows)
	dk_import	(https://github.com/weidai11/cryptopp/archive/60f81a77e0c9a0e7ffc1ca1bc438ddfa2e43b78e.zip)
	#dk_import	(https://github.com/weidai11/cryptopp/archive/refs/heads/master.zip)
endif()


### LINK ###
if(Android)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(Apple)
	dk_libDebug		(${CRYPTOPP_TUPLE_DIR}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
	dk_libRelease	(${CRYPTOPP_TUPLE_DIR}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
elseif(Emscripten)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(Linux)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(Raspberry)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
elseif(MSVC)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/cryptopp-static.lib)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/cryptopp-static.lib)
elseif(Windows)
	dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
endif()


### GENERATE ###
if(Android OR Mac)
	dk_validate(DKCMAKE_BUILD "dk_load($ENV{DKCMAKE_DIR}/DKBuildFlags.cmake)")
	string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\""	"" DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-std=c++1z" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-DMAC " " " 	DKCMAKE_BUILD "${DKCMAKE_BUILD}") #fix for class named Mac in cryptopp
	string(REPLACE "  " 		" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()

if(Android)
	dk_configure		(${CRYPTOPP_DIR} "-DCMAKE_CXX_FLAGS=/I${ANDROID_NDK}/sources/android/cpufeatures" -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(Emscripten)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(IOS)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} ${LIBMD_CMAKE})
elseif(Iossim)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} ${LIBMD_CMAKE})
elseif(Linux)	
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(Mac)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} -DCRYPTOPP_DISABLE_MIXED_ASM=ON)
elseif(Raspberry)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(Windows)
	dk_configure		(${CRYPTOPP_DIR} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
endif()

### COMPILE ###
dk_build(${CRYPTOPP} cryptopp-static)
