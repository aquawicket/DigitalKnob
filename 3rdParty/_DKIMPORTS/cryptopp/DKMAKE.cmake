# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp


### DEPEND ###
if(IOS OR IOSSIM)
	#dk_depend(libmd)
	#dk_depend(macports)
endif()


### IMPORT ###
UNIX_dk_import	(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
if(MINGW)
	WIN_dk_import	(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
else()
	WIN_dk_import	(https://github.com/weidai11/cryptopp.git PATCH)
endif()


### LINK ###
ANDROID_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
ANDROID_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
APPLE_dk_libDebug		(${CRYPTOPP}/${OS}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
APPLE_dk_libRelease		(${CRYPTOPP}/${OS}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
EMSCRIPTEN_dk_libDebug	(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
EMSCRIPTEN_dk_libRelease(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
LINUX_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
LINUX_dk_libRelease		(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
RASPBERRY_dk_libDebug	(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
RASPBERRY_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
if(MSVC)
	WIN_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
	WIN_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)
else()
	WIN_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
	WIN_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
endif()


### GENERATE ###
string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\"" "" CRYPTOPP_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "-std=c++1z" "" CRYPTOPP_BUILD "${CRYPTOPP_BUILD}")
string(REPLACE "  " " " CRYPTOPP_BUILD "${CRYPTOPP_BUILD}") 
ANDROID_dk_queueCommand		(${CRYPTOPP_BUILD} "-DCMAKE_CXX_FLAGS=/I${ANDROID_NDK}/sources/android/cpufeatures" -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})

EMSCRIPTEN_dk_configure		(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF)
IOS_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${LIBMD_CMAKE})
IOSSIM_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${LIBMD_CMAKE})
LINUX_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF)

string(REPLACE "-DMAC " " " CRYPTOPP_BUILD "${DKCMAKE_BUILD}") #fix for class named MAC in cryptopp
MAC_dk_queueCommand			(${CRYPTOPP_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF -DCRYPTOPP_DISABLE_MIXED_ASM=ON ${CRYPTOPP})

RASPBERRY_dk_configure		(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF)
WIN_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF)


### COMPILE ###
dk_build(${CRYPTOPP} cryptopp-static)
