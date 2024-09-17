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
ANDROID_dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
ANDROID_dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
APPLE_dk_libDebug		(${CRYPTOPP_TRIPLE_DIR}/cryptopp.build/${DEBUG_DIR}/cryptopp-object.build/libcryptopp-object.a)
APPLE_dk_libRelease		(${CRYPTOPP_TRIPLE_DIR}/cryptopp.build/${RELEASE_DIR}/cryptopp-object.build/libcryptopp-object.a)
EMSCRIPTEN_dk_libDebug	(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
EMSCRIPTEN_dk_libRelease(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
LINUX_dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
LINUX_dk_libRelease		(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
RASPBERRY_dk_libDebug	(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
RASPBERRY_dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
if(MSVC)
	WIN_dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/cryptopp-static.lib)
	WIN_dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/cryptopp-static.lib)
else()
	WIN_dk_libDebug		(${CRYPTOPP_DEBUG_DIR}/libcryptopp.a)
	WIN_dk_libRelease	(${CRYPTOPP_RELEASE_DIR}/libcryptopp.a)
endif()


### GENERATE ###
if(ANDROID OR MAC)
	dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
	string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\""	"" DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-std=c++1z" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-DMAC " " " 	DKCMAKE_BUILD "${DKCMAKE_BUILD}") #fix for class named MAC in cryptopp
	string(REPLACE "  " 		" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()

ANDROID_dk_configure		(${CRYPTOPP} "-DCMAKE_CXX_FLAGS=/I${ANDROID_NDK}/sources/android/cpufeatures" -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)
EMSCRIPTEN_dk_configure		(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)
IOS_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF ${LIBMD_CMAKE})
IOSSIM_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF ${LIBMD_CMAKE})
LINUX_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)
MAC_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF -DCRYPTOPP_DISABLE_MIXED_ASM=ON)
RASPBERRY_dk_configure		(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)
WIN_dk_configure			(${CRYPTOPP} -DBUILD_STATIC=ON -DBUILD_SHARED=OFF)


### COMPILE ###
dk_build(${CRYPTOPP} cryptopp-static)
