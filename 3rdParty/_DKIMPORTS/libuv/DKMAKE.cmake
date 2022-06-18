# https://github.com/libuv/libuv


#dk_import(https://github.com/libuv/libuv)
dk_import(https://github.com/libuv/libuv/archive/2bc22c40eb68f3b38d1ae3ea68ef2f180cbe9fef.zip)
#dk_set(LIBUV_MAJOR 1)
#dk_set(LIBUV_MINOR 42)
#dk_set(LIBUV_BUILD 0)
#dk_set(LIBUV_VERSION ${LIBUV_MAJOR}.${LIBUV_MINOR}.${LIBUV_BUILD})
#dk_set(LIBUV_NAME libuv-${LIBUV_VERSION})
#dk_set(LIBUV_DL https://github.com/libuv/libuv/archive/refs/tags/v1.42.0.zip)
#dk_set(LIBUV ${3RDPARTY}/${LIBUV_NAME})
#dk_install(${LIBUV_DL} libuv ${LIBUV})



### DKPLUGINS LINK ###
WIN_DKLIB(Iphlpapi.lib)
WIN_DKLIB(Userenv.lib)
dk_include(${LIBUV}/include)
dk_include(${LIBUV}/${OS})
WIN_dk_libDebug(${LIBUV}/${OS}/${DEBUG_DIR}/uv_a.lib)
WIN_dk_libRelease(${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.lib)
MAC_dk_libDebug(${LIBUV}/${OS}/lib/${DEBUG_DIR}/libuv_a.a)
MAC_dk_libRelease(${LIBUV}/${OS}/lib/${RELEASE_DIR}/libuv_a.a)
IOSSIM_dk_libDebug(${LIBUV}/${OS}/${DEBUG_DIR}/lib/.libs/libuv_a.a)
IOSSIM_dk_libRelease(${LIBUV}/${OS}/${RELEASE_DIR}/lib/.libs/libuv_a.a)
LINUX_dk_libDebug(${LIBUV}/${OS}/${DEBUG_DIR}/libuv_a.a)
LINUX_dk_libRelease(${LIBUV}/${OS}/${RELEASE_DIR}/libuv_a.a)
RASPBERRY_dk_libDebug(${LIBUV}/${OS}/${DEBUG_DIR}/libuv_a.a)
RASPBERRY_dk_libRelease(${LIBUV}/${OS}/${RELEASE_DIR}/libuv_a.a)
## ANDROID_dk_libDebug(${LIBUV}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libuv_a.a)
## ANDROID_dk_libRelease(${LIBUV}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libuv_a.a)
ANDROID_dk_libDebug(${LIBUV}/${OS}/${DEBUG_DIR}/libuv_a.a)
ANDROID_dk_libRelease(${LIBUV}/${OS}/${RELEASE_DIR}/libuv_a.a)



### 3RDPARTY LINK ###
WIN_dk_set(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.lib)
APPLE_dk_set(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.a)
LINUX_dk_set(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.a)
RASPBERRY_dk_set(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.a)
ANDROID_dk_set(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.a)



### COMPILE ###
WIN_dk_setPath(${LIBUV}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
WIN_dk_VisualStudio(${LIBUV_NAME} libuv.sln uv_a)


MAC_dk_setPath(${LIBUV}/${OS})
MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
MAC_dk_xcode(${LIBUV_NAME} uv_a)


IOS_dk_setPath(${LIBUV}/${OS})
IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
IOS_dk_xcode(${LIBUV_NAME} uv_a)


IOSSIM_dk_setPath(${LIBUV}/${OS})
IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
IOSSIM_dk_xcode(${LIBUV_NAME} uv_a)


LINUX_DEBUG_dk_setPath(${LIBUV}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
LINUX_DEBUG_dk_queueCommand(make uv_a)

LINUX_RELEASE_dk_setPath(${LIBUV}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
LINUX_RELEASE_dk_queueCommand(make uv_a)


RASPBERRY_DEBUG_dk_setPath(${LIBUV}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
RASPBERRY_DEBUG_dk_queueCommand(make uv_a)

RASPBERRY_RELEASE_dk_setPath(${LIBUV}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
RASPBERRY_RELEASE_dk_queueCommand(make uv_a)


## ANDROID_dk_ndk(${LIBUV_NAME})
ANDROID_dk_setPath(${LIBUV}/${OS})
ANDROID32_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
ANDROID64_dk_queueCommand(${DKCMAKE_BUILD} ${LIBUV})
ANDROID_dk_VisualStudio(${LIBUV_NAME} libuv.sln uv_a)