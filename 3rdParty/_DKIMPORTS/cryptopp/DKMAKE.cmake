include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp


### DEPEND ###
if(IOS OR IOSSIM)
	#dk_depend(libmd)
	#dk_depend(macports)
endif()


### IMPORT ###
UNIX_dk_import		(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
if(MINGW)
	WIN_dk_import	(https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip PATCH)
else()
	#WIN_dk_import	(https://github.com/weidai11/cryptopp.git PATCH)
	WIN_dk_import	(https://github.com/weidai11/cryptopp/archive/refs/heads/master.zip)
endif()


### LINK ###
ANDROID_TARGET_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
ANDROID_TARGET_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
APPLE_dk_libDebug		(${CRYPTOPP}/${OS}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
APPLE_dk_libRelease		(${CRYPTOPP}/${OS}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
EMSCRIPTEN_TARGET_dk_libDebug	(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
EMSCRIPTEN_TARGET_dk_libRelease(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
LINUX_TARGET_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
LINUX_TARGET_dk_libRelease		(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
RASPBERRY_TARGET_dk_libDebug	(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
RASPBERRY_TARGET_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
if(MSVC)
	WIN_TARGET_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
	WIN_TARGET_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)
else()
	WIN_TARGET_dk_libDebug		(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
	WIN_TARGET_dk_libRelease	(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
endif()


### GENERATE ###
string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\"" "" CRYPTOPP_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "-std=c++1z" "" CRYPTOPP_BUILD "${CRYPTOPP_BUILD}")
string(REPLACE "  " " " CRYPTOPP_BUILD "${CRYPTOPP_BUILD}") 
ANDROID_dk_queueCommand		(${CRYPTOPP_BUILD} "-DCMAKE_CXX_FLAGS=/I${ANDROID_NDK}/sources/android/cpufeatures" -DBUILD_STATIC=ON -DBUILD_SHARED=OFF ${CRYPTOPP})

EMSCRIPTEN_TARGET_dk_configure		(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)
IOS_TARGET_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF ${LIBMD_CMAKE})
IOSSIM_TARGET_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF ${LIBMD_CMAKE})
LINUX_TARGET_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)

string(REPLACE "-DMAC " " " CRYPTOPP_BUILD "${DKCMAKE_BUILD}") #fix for class named MAC in cryptopp
MAC_TARGET_dk_queueCommand			(${CRYPTOPP_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DCRYPTOPP_DISABLE_MIXED_ASM=ON ${CRYPTOPP})

RASPBERRY_TARGET_dk_configure		(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)
WIN_TARGET_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)


### COMPILE ###
dk_build(${CRYPTOPP} cryptopp-static)
