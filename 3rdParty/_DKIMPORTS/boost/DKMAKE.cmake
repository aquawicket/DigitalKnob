## https://www.boost.org/
# Debugging: When calling b2 to compile the boost libraries, you can use the -q flag to make it stop at the first error.
# Notes: abi=aapcs and binary-format=elf were added to android build to supress "No best alternative for libs/context/build/asm_sources"

### VERSION ###
DKSET(BOOST_VERSION_MAJOR 1)
DKSET(BOOST_VERSION_MINOR 74)
DKSET(BOOST_VERSION_BUILD 0)
DKSET(BOOST_VERSION ${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}_${BOOST_VERSION_BUILD})
DKSET(BOOST_NAME boost_${BOOST_VERSION})
DKSET(BOOST ${3RDPARTY}/${BOOST_NAME})


### INSTALL ###
## https://sourceforge.net/projects/boost/files/boost/1.74.0/boost_1_74_0.zip
## https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.zip
DKINSTALL(https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION_MAJOR}.${BOOST_VERSION_MINOR}.${BOOST_VERSION_BUILD}/boost_${BOOST_VERSION}.zip boost ${BOOST_NAME})


### DKPLUGINS LINK ###
DKINCLUDE(${BOOST})
DKLINKDIR(${BOOST}/${OS}/${DEBUG_DIR}/lib)
DKLINKDIR(${BOOST}/${OS}/${RELEASE_DIR}/lib)

IF(STATIC)

IF(Boost_Atomic)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF()
IF(Boost_Chrono)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF()
IF(Boost_DateTime)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF()
IF(Boost_Filesystem)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF()
IF(Boost_Random)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF()
IF(Boost_System)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF() 
IF(Boost_Thread)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread-vc142-mt-sgd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread-vc142-mt-s-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread-vc142-mt-sgd-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread-vc142-mt-s-x64-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread-clang-mt-d-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread-clang-mt-a32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.a)
ENDIF()


### COMPILE ###
WIN32_PATH(${BOOST})
WIN32_COMMAND(bootstrap.bat)
WIN32_DEBUG_COMMAND(b2 toolset=msvc-14.2 address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN32_RELEASE_COMMAND(b2 toolset=msvc-14.2 address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

## WIN64_COMMAND(call C:/Windows/System32/cmd.exe /E:ON /V:ON /T:0E /K "${WINDOWS_SDK_EXE}")
WIN64_PATH(${BOOST})
WIN64_COMMAND(bootstrap.bat)
WIN64_DEBUG_COMMAND(b2 toolset=msvc-14.2 address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN64_RELEASE_COMMAND(b2 toolset=msvc-14.2 address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

MAC32_PATH(${BOOST})
MAC32_COMMAND(./bootstrap.sh)
MAC32_DEBUG_COMMAND(./b2 toolset=darwin address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC32_RELEASE_COMMAND(./b2 toolset=darwin address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

MAC64_PATH(${BOOST})
MAC64_COMMAND(./bootstrap.sh)
MAC64_DEBUG_COMMAND(./b2 toolset=darwin address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC64_RELEASE_COMMAND(./b2 toolset=darwin address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

LINUX32_PATH(${BOOST})
LINUX32_COMMAND(./bootstrap.sh)
LINUX32_DEBUG_COMMAND(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX32_RELEASE_COMMAND(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

LINUX64_PATH(${BOOST})
LINUX64_COMMAND(./bootstrap.sh)
LINUX64_DEBUG_COMMAND(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX64_RELEASE_COMMAND(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

RASPBERRY32_PATH(${BOOST})
RASPBERRY32_COMMAND(./bootstrap.sh)
RASPBERRY32_DEBUG_COMMAND(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY32_RELEASE_COMMAND(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

RASPBERRY64_PATH(${BOOST})
RASPBERRY64_COMMAND(./bootstrap.sh)
RASPBERRY64_DEBUG_COMMAND(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY64_RELEASE_COMMAND(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

ANDROID32_PATH(${BOOST})
ANDROID32_BASH("#!/bin/bash\;
cd /${BOOST}\;
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
./SetupAndroid.sh\;")
ANDROID32_DEBUG_COMMAND(set ANDROIDNDKROOT=${NDK} && set NDKVER=r21e && set CLANGPATH=%ANDROIDNDKROOT%/toolchains/llvm/prebuilt/windows-x86_64/bin && b2 toolset=clang-armeabiv7a architecture=arm variant=debug link=static threading=multi target-os=android -j4 --layout=versioned --ignore-site-config --user-config=${BOOST}/android-config.jam --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR} --without-python abi=aapcs binary-format=elf)
ANDROID32_RELEASE_COMMAND(set ANDROIDNDKROOT=${NDK} && set NDKVER=r21e && set CLANGPATH=%ANDROIDNDKROOT%/toolchains/llvm/prebuilt/windows-x86_64/bin && b2 toolset=clang-armeabiv7a architecture=arm variant=release link=static threading=multi target-os=android -j4 --layout=versioned --ignore-site-config --user-config=${BOOST}/android-config.jam --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR} --without-python abi=aapcs binary-format=elf)


## FIXME
ANDROID64_PATH(${BOOST})
ANDROID64_BASH("#!/bin/bash\;
cd /${BOOST}\;
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
./SetupAndroid.sh\;")
ANDROID64_DEBUG_COMMAND(set ANDROIDNDKROOT=${NDK} && set NDKVER=r21e && set CLANGPATH=%ANDROIDNDKROOT%/toolchains/llvm/prebuilt/windows-x86_64/bin && b2 toolset=clang-armeabiv7a architecture=arm variant=debug link=static threading=multi target-os=android -j4 --layout=versioned --ignore-site-config --user-config=${BOOST}/android-config.jam --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR} --without-python abi=aapcs binary-format=elf)
ANDROID64_RELEASE_COMMAND(set ANDROIDNDKROOT=${NDK} && set NDKVER=r21e && set CLANGPATH=%ANDROIDNDKROOT%/toolchains/llvm/prebuilt/windows-x86_64/bin && b2 toolset=clang-armeabiv7a architecture=arm variant=release link=static threading=multi target-os=android -j4 --layout=versioned --ignore-site-config --user-config=${BOOST}/android-config.jam --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR} --without-python abi=aapcs binary-format=elf)

ENDIF(STATIC)


### TODO
IF(SHARED)

IF(Boost_Filesystem)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/lib/boost_filesystem-vc142-mt-gd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/lib/boost_filesystem-vc142-mt-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
ENDIF()

IF(Boost_System)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/lib/boost_system-vc142-mt-gd-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/lib/boost_system-vc142-mt-x32-${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}.lib)
ENDIF()

#WIN32_COMMAND(b2 install toolset=msvc-14.0 --prefix=${BOOSTBUILD})
#DKSETPATH(${BOOST})
#WIN32_COMMAND(b2 toolset=msvc-14.0 link=shared variant=debug runtime-debugging=on runtime-link=shared --threading=multi --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
#WIN32_COMMAND(b2 toolset=msvc-14.0 link=shared variant=release runtime-debugging=off runtime-link=shared --threading=multi --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR}/)

ENDIF(SHARED)
