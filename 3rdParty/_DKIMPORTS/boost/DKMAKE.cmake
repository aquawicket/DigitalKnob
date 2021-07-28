## https://www.boost.org/
## https://www.boost.org/doc/libs/1_76_0/tools/build/doc/html/index.html - B2 User Manual - 1.76.0
## https://github.com/LibCMaker/LibCMaker#readme

# Debugging: When calling b2 to compile the boost libraries, you can use the -q flag to make it stop at the first error.
# Notes: abi=aapcs and binary-format=elf were added to android build to supress "No best alternative for libs/context/build/asm_sources"

### DEPENDS ###
if(ANDROID)
	DKDEPEND(android-sdk) #version 21e or newer required
	DKDEPEND(mingw32)
endif()


### VERSION ###
DKSET(BOOST_MAJOR 1)
DKSET(BOOST_MINOR 74)
DKSET(BOOST_BUILD 0)
DKSET(BOOST_VERSION ${BOOST_MAJOR}_${BOOST_MINOR}_${BOOST_BUILD})
DKSET(BOOST_NAME boost_${BOOST_VERSION})
DKSET(BOOST ${3RDPARTY}/${BOOST_NAME})


### INSTALL ###
## https://sourceforge.net/projects/boost/files/boost/1.74.0/boost_1_74_0.zip
## https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.zip
DKINSTALL(https://sourceforge.net/projects/boost/files/boost/${BOOST_MAJOR}.${BOOST_MINOR}.${BOOST_BUILD}/${BOOST_NAME}.zip boost ${BOOST_NAME})


### DKPLUGINS LINK ###
##DKDEFINE(USE_Boost)
DKDEFINE(BOOST_ALL_NO_LIB=1)
DKDEFINE(BOOST_REGEX_DYN_LINK=1)
DKINCLUDE(${BOOST})
DKLINKDIR(${BOOST}/${OS}/${DEBUG_DIR}/lib)
DKLINKDIR(${BOOST}/${OS}/${RELEASE_DIR}/lib)

IF(STATIC)

IF(Boost_Atomic)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_atomic.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_atomic.a)
ENDIF()
IF(Boost_Chrono)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_chrono.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_chrono.a)
ENDIF()
IF(Boost_DateTime)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_date_time.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_date_time.a)
ENDIF()
IF(Boost_Filesystem)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_filesystem.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_filesystem.a)
ENDIF()
IF(Boost_Random)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_random.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_random.a)
ENDIF()
IF(Boost_System)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_system.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_system.a)
ENDIF() 
IF(Boost_Thread)
	WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.lib)
	WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.lib)
	WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.lib)
	WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.lib)
	APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
	LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
	RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
	ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_thread.a)
	ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_thread.a)
ENDIF()


### COMPILE ###
WIN32_PATH(${BOOST})
WIN32_COMMAND(bootstrap.bat)
WIN32_DEBUG_COMMAND(b2 toolset=msvc-14.2 address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN32_RELEASE_COMMAND(b2 toolset=msvc-14.2 address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


WIN64_PATH(${BOOST})
WIN64_COMMAND(bootstrap.bat)
WIN64_DEBUG_COMMAND(b2 toolset=msvc-14.2 address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN64_RELEASE_COMMAND(b2 toolset=msvc-14.2 address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


MAC32_PATH(${BOOST})
MAC32_COMMAND(./bootstrap.sh)
MAC32_DEBUG_COMMAND(./b2 toolset=darwin address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC32_RELEASE_COMMAND(./b2 toolset=darwin address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


MAC64_PATH(${BOOST})
MAC64_COMMAND(./bootstrap.sh)
MAC64_DEBUG_COMMAND(./b2 toolset=darwin address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC64_RELEASE_COMMAND(./b2 toolset=darwin address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


LINUX32_PATH(${BOOST})
LINUX32_COMMAND(./bootstrap.sh)
LINUX32_DEBUG_COMMAND(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX32_RELEASE_COMMAND(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

LINUX64_PATH(${BOOST})
LINUX64_COMMAND(./bootstrap.sh)
LINUX64_DEBUG_COMMAND(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX64_RELEASE_COMMAND(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


RASPBERRY32_PATH(${BOOST})
RASPBERRY32_COMMAND(./bootstrap.sh)
RASPBERRY32_DEBUG_COMMAND(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY32_RELEASE_COMMAND(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

RASPBERRY64_PATH(${BOOST})
RASPBERRY64_COMMAND(./bootstrap.sh)
RASPBERRY64_DEBUG_COMMAND(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY64_RELEASE_COMMAND(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


ANDROID_PATH(${BOOST})
ANDROID_BASH("#!/bin/bash\;
cd /${BOOST}\;
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
./SetupAndroid.sh\;")


ANDROID32_DEBUG_COMMAND(
	set ANDROIDNDKROOT=${ANDROIDNDK} &&
	set NDKVER=${ANDROIDNDK_VERSION} &&
	set CLANGPATH=${ANDROIDNDK}/toolchains/llvm/prebuilt/windows-x86_64/bin &&
	b2
	toolset=clang-armeabiv7a
	architecture=arm
	variant=debug
	link=static
	threading=multi
	target-os=android
	-j4
	--ignore-site-config
	--layout=system
	--user-config=${BOOST}/android-config.jam
	--build-dir=${BOOST}/${OS}/${DEBUG_DIR}
	--stagedir=${BOOST}/${OS}/${DEBUG_DIR}
	--without-python
	abi=aapcs
	binary-format=elf )

ANDROID32_RELEASE_COMMAND(
	set ANDROIDNDKROOT=${ANDROIDNDK} &&
	set NDKVER=${ANDROIDNDK_VERSION} &&
	set CLANGPATH=${ANDROIDNDK}/toolchains/llvm/prebuilt/windows-x86_64/bin &&
	b2
	toolset=clang-armeabiv7a
	architecture=arm
	variant=release
	link=static
	threading=multi
	target-os=android
	-j4
	--ignore-site-config
	--layout=system
	--user-config=${BOOST}/android-config.jam
	--build-dir=${BOOST}/${OS}/${RELEASE_DIR}
	--stagedir=${BOOST}/${OS}/${RELEASE_DIR}
	--without-python
	abi=aapcs
	binary-format=elf )

ANDROID64_DEBUG_COMMAND(
	set ANDROIDNDKROOT=${ANDROIDNDK} &&
	set NDKVER=${ANDROIDNDK_VERSION} &&
	set CLANGPATH=${ANDROIDNDK}/toolchains/llvm/prebuilt/windows-x86_64/bin &&
	echo "\n\nStarting B2 for Android arm64v8a . . .\n " &&
	b2
	toolset=clang-arm64v8a
	architecture=arm
	address-model=64
	variant=debug
	link=static
	threading=multi
	target-os=android
	-j4
	--ignore-site-config
	--layout=system
	--user-config=${BOOST}/android-config.jam
	--build-dir=${BOOST}/${OS}/${DEBUG_DIR}
	--stagedir=${BOOST}/${OS}/${DEBUG_DIR}
	--without-python
	abi=aapcs
	binary-format=elf )
	
ANDROID64_RELEASE_COMMAND(
	set ANDROIDNDKROOT=${ANDROIDNDK} &&
	set NDKVER=${ANDROIDNDK_VERSION} &&
	set CLANGPATH=${ANDROIDNDK}/toolchains/llvm/prebuilt/windows-x86_64/bin &&
	b2
	toolset=clang-arm64v8a
	architecture=arm
	address-model=64
	variant=release
	link=static
	threading=multi
	target-os=android
	-j4
	--ignore-site-config
	--layout=system
	--user-config=${BOOST}/android-config.jam
	--build-dir=${BOOST}/${OS}/${RELEASE_DIR}
	--stagedir=${BOOST}/${OS}/${RELEASE_DIR}
	--without-python
	abi=aapcs
	binary-format=elf )

ENDIF(STATIC)


### TODO
IF(SHARED)

#IF(Boost_Filesystem)
#	WIN32_DEBUG_LIB(${BOOST}/${OS}/lib/boost_filesystem.lib)
#	WIN32_RELEASE_LIB(${BOOST}/${OS}/lib/boost_filesystem.lib)
#ENDIF()

#IF(Boost_System)
#	WIN32_DEBUG_LIB(${BOOST}/${OS}/lib/boost_system.lib)
#	WIN32_RELEASE_LIB(${BOOST}/${OS}/lib/boost_system.lib)
#ENDIF()

#WIN_PATH(${BOOST})
#WIN32_COMMAND(bootstrap.bat)
#WIN_COMMAND(b2 toolset=msvc-14.0 link=shared variant=debug runtime-debugging=on runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
#WIN_COMMAND(b2 toolset=msvc-14.0 link=shared variant=release runtime-debugging=off runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

ENDIF(SHARED)
