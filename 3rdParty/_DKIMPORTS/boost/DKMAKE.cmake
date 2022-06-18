# https://github.com/boostorg/boost
# https://www.boost.org/
# https://www.boost.org/doc/libs/1_76_0/tools/build/doc/html/index.html - B2 User Manual - 1.76.0
# https://github.com/LibCMaker/LibCMaker#readme
#
# https://versaweb.dl.sourceforge.net/project/boost/boost/1.78.0/boost_1_78_0.zip
# https://sourceforge.net/projects/boost/files/boost/1.78.0/boost_1_78_0.zip
# https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.zip

# Debugging: When calling b2 to compile the boost libraries, you can use the -q flag to make it stop at the first error.
# Notes: abi=aapcs and binary-format=elf were added to android build to supress "No best alternative for libs/context/build/asm_sources"

### DEPENDS ###
ANDROID_dk_depend(android-ndk) #version 21e or newer required
ANDROID_dk_depend(mingw32)
ANDROID_dk_depend(mingw64)

### IMPORT ###
#DKINPORT_GIT(https://github.com/boostorg/boost.git)
#dk_import(https://versaweb.dl.sourceforge.net/project/boost/boost/1.78.0/boost_1_78_0.zip)

### VERSION ###
dk_set(BOOST_MAJOR 1)
dk_set(BOOST_MINOR 78)
dk_set(BOOST_BUILD 0)
dk_set(BOOST_DL https://versaweb.dl.sourceforge.net/project/boost/boost/1.78.0/boost_1_78_0.zip)
dk_set(BOOST_VERSION ${BOOST_MAJOR}_${BOOST_MINOR}_${BOOST_BUILD})
dk_set(BOOST_NAME boost_${BOOST_VERSION})
dk_set(BOOST ${3RDPARTY}/${BOOST_NAME})
dk_install(${BOOST_DL} boost ${BOOST} PATCH)


### DKPLUGINS LINK ###
##dk_define(HAVE_Boost)
dk_define(BOOST_ALL_NO_LIB=1)
dk_define(BOOST_REGEX_DYN_LINK=1)
dk_include(${BOOST})
dk_linkDir(${BOOST}/${OS}/${DEBUG_DIR}/lib)
dk_linkDir(${BOOST}/${OS}/${RELEASE_DIR}/lib)

dk_addTarget(boost atomic)
dk_addTarget(boost chrono)
dk_addTarget(boost container)
dk_addTarget(boost context)
dk_addTarget(boost contract)
dk_addTarget(boost coroutine)
dk_addTarget(boost date_time)
dk_addTarget(boost exception)
dk_addTarget(boost fiber)
dk_addTarget(boost filesystem)
dk_addTarget(boost graph)
dk_addTarget(boost graph_parallel)
dk_addTarget(boost headers)
dk_addTarget(boost iostreams)
dk_addTarget(boost json)
dk_addTarget(boost locale)
dk_addTarget(boost log)
dk_addTarget(boost math)
dk_addTarget(boost mpi)
dk_addTarget(boost nowide)
dk_addTarget(boost program_options)
dk_addTarget(boost python)
dk_addTarget(boost random)
dk_addTarget(boost regex)
dk_addTarget(boost serialization)
dk_addTarget(boost stacktrace)
dk_addTarget(boost system)
dk_addTarget(boost test)
dk_addTarget(boost thread)
dk_addTarget(boost timer)
dk_addTarget(boost type_erasure)
dk_addTarget(boost wave)

#build these, but don't look for libraries
dk_set(boost_fiber_nolib 1)
dk_set(boost_graph_parallel_nolib 1)
dk_set(boost_headers_nolib 1)
dk_set(boost_math_nolib 1)
dk_set(boost_mpi_nolib 1)
dk_set(boost_python_nolib 1)
dk_set(boost_test_nolib 1)
dk_set(boost_stacktrace_nolib 1)
if(MAC)
	dk_removeTarget(boost json)
	dk_removeTarget(boost locale)
	dk_removeTarget(boost nowide)
endif()
if(LINUX)
	dk_removeTarget(boost python)
endif()
if(RASPBERRY)
	dk_removeTarget(boost python)
endif()
if(ANDROID)
	dk_removeTarget(boost context)
	dk_removeTarget(boost coroutine)
	dk_removeTarget(boost fiber)
	dk_removeTarget(boost json)
	dk_removeTarget(boost locale)
	dk_removeTarget(boost nowide)
	dk_removeTarget(boost python)
	dk_removeTarget(boost type_erasure)
endif()

if(STATIC)


foreach(lib_OFF ${boost_targets_OFF})
	if(lib_OFF)
		dk_set(BOOST_WITHOUT ${BOOST_WITHOUT} --without-${lib_OFF})
	endif()
endforeach()

foreach(lib ${boost_targets})
	if(boost_${lib} AND NOT boost_${lib}_nolib)
		WIN32_dk_libDebug(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.lib)
		WIN32_dk_libRelease(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.lib)
		WIN64_dk_libDebug(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.lib)
		WIN64_dk_libRelease(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.lib)
		APPLE_dk_libDebug(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		APPLE_dk_libRelease(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
		LINUX_dk_libDebug(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		LINUX_dk_libRelease(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
		RASPBERRY_dk_libDebug(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		RASPBERRY_dk_libRelease(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
		ANDROID_dk_libDebug(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		ANDROID_dk_libRelease(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
	endif()
endforeach()


### COMPILE ###
dk_setPath(${BOOST})
if(NOT EXISTS ${BOOST}/b2.exe)
	WIN_HOST_dk_queueCommand(bootstrap.bat vc143)
endif()
if(NOT EXISTS ${BOOST}/b2)
	UNIX_HOST_dk_queueCommand(./bootstrap.sh)
endif()



WIN32_DEBUG_dk_queueCommand(b2.exe toolset=msvc-14.3 address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN32_RELEASE_dk_queueCommand(b2.exe toolset=msvc-14.3 address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


WIN64_DEBUG_dk_queueCommand(b2.exe toolset=msvc-14.3 address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN64_RELEASE_dk_queueCommand(b2 toolset=msvc-14.3 address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


MAC32_DEBUG_dk_queueCommand(./b2 toolset=darwin address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC32_RELEASE_dk_queueCommand(./b2 toolset=darwin address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


MAC64_DEBUG_dk_queueCommand(./b2 toolset=darwin address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC64_RELEASE_dk_queueCommand(./b2 toolset=darwin address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

# TODO
#IOSSIM64_DEBUG_dk_queueCommand(./b2 toolset=darwin address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} #--build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
#IOSSIM64_RELEASE_CDKQOMMAND(./b2 toolset=darwin address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} #--build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


LINUX32_DEBUG_dk_queueCommand(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX32_RELEASE_dk_queueCommand(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


LINUX64_DEBUG_dk_queueCommand(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX64_RELEASE_dk_queueCommand(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


RASPBERRY32_DEBUG_dk_queueCommand(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY32_RELEASE_dk_queueCommand(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


RASPBERRY64_DEBUG_dk_queueCommand(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY64_RELEASE_dk_queueCommand(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system ${BOOST_WITH} ${BOOST_WITHOUT} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})



ANDROID_dk_msys(./SetupAndroid.sh)

ANDROID32_DEBUG_dk_queueCommand(
	#setx NDK_ROOT ${ANDROIDNDK} &&
	b2.exe
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
	${BOOST_WITH}
	${BOOST_WITHOUT}
	abi=aapcs
	binary-format=elf )

ANDROID32_RELEASE_dk_queueCommand(
	#setx NDK_ROOT ${ANDROIDNDK} &&
	b2.exe
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
	${BOOST_WITH}
	${BOOST_WITHOUT}
	abi=aapcs
	binary-format=elf )

ANDROID64_DEBUG_dk_queueCommand(
	#setx NDK_ROOT ${ANDROIDNDK} &&
	b2.exe
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
	${BOOST_WITH}
	${BOOST_WITHOUT}
	abi=aapcs
	binary-format=elf )
	
ANDROID64_RELEASE_dk_queueCommand(
	#setx NDK_ROOT ${ANDROIDNDK} &&
	b2.exe
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
	${BOOST_WITH}
	${BOOST_WITHOUT}
	abi=aapcs
	binary-format=elf )

endif(STATIC)


### TODO
if(SHARED)

#if(boost_filesystem)
#	WIN32_dk_libDebug(${BOOST}/${OS}/lib/boost_filesystem.lib)
#	WIN32_dk_libRelease(${BOOST}/${OS}/lib/boost_filesystem.lib)
#endif()

#if(boost_system)
#	WIN32_dk_libDebug(${BOOST}/${OS}/lib/boost_system.lib)
#	WIN32_dk_libRelease(${BOOST}/${OS}/lib/boost_system.lib)
#endif()

#WIN_dk_setPath(${BOOST})
#WIN32_dk_queueCommand(bootstrap.bat)
#WIN_dk_queueCommand(b2 toolset=msvc-14.0 link=shared variant=debug runtime-debugging=on runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
#WIN_dk_queueCommand(b2 toolset=msvc-14.0 link=shared variant=release runtime-debugging=off runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

endif(SHARED)
