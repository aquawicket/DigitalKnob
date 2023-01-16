# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp


### DEPEND ###
if(IOS OR IOSSIM)
	#dk_depend(libmd)
	#dk_depend(macports)
endif()


### IMPORT ###
if(WIN)
	#dk_import(https://github.com/weidai11/cryptopp/archive/27b7b8e4e6b3e54cca13b2faae87eb95faa0d819.zip PATCH)
	dk_import(https://github.com/weidai11/cryptopp.git PATCH)
else()
	dk_import(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
	#dk_import(https://github.com/weidai11/cryptopp.git PATCH)
endif()


### LINK ###
WIN_dk_libDebug			(${CRYPTOPP}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
WIN_dk_libRelease		(${CRYPTOPP}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)
APPLE_dk_libDebug		(${CRYPTOPP}/${OS}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
APPLE_dk_libRelease		(${CRYPTOPP}/${OS}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
LINUX_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
LINUX_dk_libRelease		(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
RASPBERRY_dk_libDebug	(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
RASPBERRY_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
ANDROID_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
ANDROID_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
EMSCRIPTEN_dk_libDebug	(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
EMSCRIPTEN_dk_libRelease(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)


### GENERATE ###
WIN_dk_queueCommand			(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
string(REPLACE "-DMAC " " " DKCMAKE_BUILD_CRYPTOPP "${DKCMAKE_BUILD}") #fix for class named MAC in cryptopp
MAC_dk_queueCommand			(${DKCMAKE_BUILD_CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF -DCRYPTOPP_DISABLE_MIXED_ASM=ON ${CRYPTOPP})
IOS_dk_queueCommand			(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${LIBMD_CMAKE} ${CRYPTOPP})
IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${LIBMD_CMAKE} ${CRYPTOPP})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\"" "" DKCMAKE_BUILD_CRYPTOPP "${DKCMAKE_BUILD}")
string(REPLACE "-std=c++1z" "" DKCMAKE_BUILD_CRYPTOPP "${DKCMAKE_BUILD_CRYPTOPP}")
string(REPLACE "  " " " DKCMAKE_BUILD_CRYPTOPP "${DKCMAKE_BUILD_CRYPTOPP}") 
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD_CRYPTOPP} "-DCMAKE_CXX_FLAGS=/I${ANDROID-NDK}/sources/android/cpufeatures" -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})


### COMPILE ###
dk_build(${CRYPTOPP} cryptopp-static)
