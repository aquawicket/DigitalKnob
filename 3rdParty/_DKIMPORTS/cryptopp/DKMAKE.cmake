# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp

if(IOSSIM)
	#dk_depend(libmd)
	#dk_depend(macports)
endif()

if(WIN)
	#dk_import(https://github.com/weidai11/cryptopp.git)
	dk_import(https://github.com/weidai11/cryptopp/archive/27b7b8e4e6b3e54cca13b2faae87eb95faa0d819.zip PATCH)
else()
	dk_set(CRYPTOPP_VERSION 8_5_0)
	dk_set(CRYPTOPP_DL https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip)
	dk_set(CRYPTOPP_NAME CRYPTOPP_${CRYPTOPP_VERSION})
	dk_set(CRYPTOPP ${3RDPARTY}/${CRYPTOPP_NAME})
	dk_install(${CRYPTOPP_DL} cryptopp ${CRYPTOPP} PATCH)
endif()

### LINK ###
WIN_DEBUG_DKLIB(${CRYPTOPP}/${OS}/${DEBUG_DIR}/cryptopp-static.lib)
WIN_RELEASE_DKLIB(${CRYPTOPP}/${OS}/${RELEASE_DIR}/cryptopp-static.lib)
APPLE_DEBUG_DKLIB(${CRYPTOPP}/${OS}/cryptopp.build/Debug/cryptopp-object.build/libcryptopp-object.a)
APPLE_RELEASE_DKLIB(${CRYPTOPP}/${OS}/cryptopp.build/Release/cryptopp-object.build/libcryptopp-object.a)
LINUX_DEBUG_DKLIB(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
LINUX_RELEASE_DKLIB(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
RASPBERRY_DEBUG_DKLIB(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
RASPBERRY_RELEASE_DKLIB(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)
ANDROID_DEBUG_DKLIB(${CRYPTOPP}/${OS}/${DEBUG_DIR}/libcryptopp.a)
ANDROID_RELEASE_DKLIB(${CRYPTOPP}/${OS}/${RELEASE_DIR}/libcryptopp.a)


### COMPILE ###
dk_setPath(${CRYPTOPP}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
WIN_dk_VisualStudio(${CRYPTOPP_NAME} cryptopp.sln cryptopp-static)


if(MAC)
	string(REPLACE "-DMAC " " " DKCMAKE_BUILD_CRYPTOPP "${DKCMAKE_BUILD}") #fix of class named MAC in cryptopp
endif()
MAC_dk_queueCommand(${DKCMAKE_BUILD_CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF -DCRYPTOPP_DISABLE_MIXED_ASM=ON ${CRYPTOPP})
MAC_XCODE(${CRYPTOPP_NAME} cryptopp-static)


IOS_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
IOS_XCODE(${CRYPTOPP_NAME} cryptopp-static)


IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${LIBMD_CMAKE} ${CRYPTOPP})
IOSSIM_XCODE(${CRYPTOPP_NAME} cryptopp-static)


LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
LINUX_dk_queueCommand(make cryptopp-static)


RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
RASPBERRY_dk_queueCommand(make cryptopp-static)


if(ANDROID)
	string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\"" "" DKCMAKE_BUILD_CRYPTOPP "${DKCMAKE_BUILD}")
endif(ANDROID)
ANDROID_dk_queueCommand(${DKCMAKE_BUILD_CRYPTOPP} "-DCMAKE_CXX_FLAGS=/I${ANDROIDNDK}/sources/android/cpufeatures" -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DBUILD_TESTING=OFF ${CRYPTOPP})
ANDROID_dk_VisualStudio(${CRYPTOPP_NAME} cryptopp.sln cryptopp-static)
