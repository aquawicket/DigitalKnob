# https://github.com/madler/zlib
# http://www.zlib.net/


dk_import(https://github.com/madler/zlib.git)


### LINK ###
dk_include(${ZLIB})
dk_include(${ZLIB}/${OS})
WIN_dk_libDebug(${ZLIB}/${OS}/${DEBUG_DIR}/zlibstaticd.lib)
WIN_dk_libRelease(${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib)
UNIX_dk_libDebug(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a)
UNIX_dk_libRelease(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)


## 3RDPARTY LINK ##
WIN_dk_set		(ZLIB_CMAKE "-DCMAKE_C_FLAGS=/I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=/I${ZLIB}/${OS}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY=${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/zlibstatic.lib -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib)
APPLE_dk_set	(ZLIB_CMAKE "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
LINUX_dk_set	(ZLIB_CMAKE "-DCMAKE_C_FLAGS_DEBUG=-I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_C_FLAGS_RELEASE=-I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS_RELEASE=-I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
RASPBERRY_dk_set(ZLIB_CMAKE "-DCMAKE_C_FLAGS_DEBUG=-I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_C_FLAGS_RELEASE=-I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS_RELEASE=-I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
ANDROID_dk_set	(ZLIB_CMAKE "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
#IOS_dk_set		(ZLIB_CONFIGURE_DEBUG "CFLAGS= -I${ZLIB} -I${ZLIB}/${OS} -I${ZLIB}/${OS}/${DEBUG_DIR}/libz.a" "CPPFLAGS= -I${ZLIB} -I${ZLIB}/${OS} -I${ZLIB}/${OS}/${DEBUG_DIR}/libz.a")
#IOS_dk_set		(ZLIB_CONFIGURE_RELEASE "CFLAGS= -I${ZLIB} -I${ZLIB}/${OS} -I${ZLIB}/${OS}/${RELEASE_DIR}/libz.a" "CPPFLAGS= -I${ZLIB} -I${ZLIB}/${OS} -I${ZLIB}/${OS}/${RELEASE_DIR}/libz.a")


### GENERATE ###
dk_setPath(${ZLIB}/${BUILD_DIR})
if(IOSSIM)
	IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=x86_64 ${ZLIB})
else()
	dk_queueCommand(${DKCMAKE_BUILD} ${ZLIB})
endif()


### COMPILE ###
dk_visualStudio(${ZLIB_NAME} zlibstatic) 	# windows, android
dk_xcode(${ZLIB_NAME} zlibstatic)       	# mac, ios, iossim
LINUX_dk_queueCommand(make zlibstatic)
RASPBERRY_dk_queueCommand(make zlibstatic)
