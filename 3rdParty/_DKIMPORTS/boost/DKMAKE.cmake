# https://www.boost.org/
# https://www.boost.org/doc/libs/1_76_0/tools/build/doc/html/index.html - B2 User Manual - 1.76.0
# https://github.com/LibCMaker/LibCMaker#readme
#
# https://sourceforge.net/projects/boost/files/boost/1.74.0/boost_1_74_0.zip
# https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.zip
# https://boostorg.jfrog.io/artifactory/main/beta/1.78.0.beta1/source/boost_1_78_0_b1.zip

# Debugging: When calling b2 to compile the boost libraries, you can use the -q flag to make it stop at the first error.
# Notes: abi=aapcs and binary-format=elf were added to android build to supress "No best alternative for libs/context/build/asm_sources"

### DEPENDS ###
if(ANDROID)
	DKDEPEND(android-ndk) #version 21e or newer required
	DKDEPEND(mingw32)
endif()


### VERSION ###
DKSET(BOOST_MAJOR 1)
DKSET(BOOST_MINOR 78)
DKSET(BOOST_BUILD 0_b1)
DKSET(BOOST_VERSION ${BOOST_MAJOR}_${BOOST_MINOR}_${BOOST_BUILD})
DKSET(BOOST_NAME boost_${BOOST_VERSION})
DKSET(BOOST_DL https://sourceforge.net/projects/boost/files/boost/${BOOST_MAJOR}.${BOOST_MINOR}.${BOOST_BUILD}/${BOOST_NAME}.zip)
DKSET(BOOST_DL https://boostorg.jfrog.io/artifactory/main/beta/1.78.0.beta1/source/boost_1_78_0_b1.zip)
DKSET(BOOST ${3RDPARTY}/${BOOST_NAME})


### INSTALL ###
DKINSTALL(${BOOST_DL} boost ${BOOST})


### DKPLUGINS LINK ###
##DKDEFINE(USE_Boost)
DKDEFINE(BOOST_ALL_NO_LIB=1)
DKDEFINE(BOOST_REGEX_DYN_LINK=1)
DKINCLUDE(${BOOST})
DKLINKDIR(${BOOST}/${OS}/${DEBUG_DIR}/lib)
DKLINKDIR(${BOOST}/${OS}/${RELEASE_DIR}/lib)



#DKSET(BOOST_LIBS
#accumulators
#algorithm
#align
#any
#array
#asio
#assert
#assign
dk_sublibrary(boost atomic)
#beast
#bimap
#bind
#callable_traits
dk_sublibrary(boost chrono)
#circular_buffer
#compatibility
#compute
#concept_check
#config
dk_sublibrary(boost container)
#container_hash
dk_sublibrary(boost context)
dk_sublibrary(boost contract)
#conversion
#convert
#core
dk_sublibrary(boost coroutine)
#coroutine2
#crc
dk_sublibrary(boost date_time)
#detail
#dll
#dynamic_bitset
#endian
dk_sublibrary(boost exception)
dk_sublibrary(boost fiber)
dk_sublibrary(boost filesystem)
#flyweight
#foreach
#format
#function
#functional
#function_types
#fusion
#geometry
#gil
dk_sublibrary(boost graph)
dk_sublibrary(boost graph_parallel)
#hana
dk_sublibrary(boost headers)
#heap
#histogram
#hof
#icl
#integer
#interprocess
#intrusive
#io
dk_sublibrary(boost iostreams)
#iterator
dk_sublibrary(boost json)
#lambda
#lexical_cast
dk_sublibrary(boost locale)
#local_function
#lockfree
dk_sublibrary(boost log)
#logic
dk_sublibrary(boost math)
#metaparse
#move
#mp11
dk_sublibrary(boost mpi)
#mpl
#msm
#multiprecision
#multi_array
#multi_index
dk_sublibrary(boost nowide)
#numeric
#optional
#outcome
#parameter
#parameter_python
#phoenix
#polygon
#poly_collection
#pool
#predef
#preprocessor
#process
dk_sublibrary(boost program_options)
#property_map
#property_tree
#proto
#ptr_container
dk_sublibrary(boost python)
#qvm
dk_sublibrary(boost random)
#range
#ratio
#rational
dk_sublibrary(boost regex)
#safe_numerics
#scope_exit
dk_sublibrary(boost serialization)
#signals2
#smart_ptr
#sort
#spirit
dk_sublibrary(boost stacktrace)
#statechart
#static_assert
#static_string
#stl_interfaces
dk_sublibrary(boost system)
dk_sublibrary(boost test)
dk_sublibrary(boost thread)
#throw_exception
dk_sublibrary(boost timer)
#tokenizer
#tti
#tuple
#typeof
dk_sublibrary(boost type_erasure)
#type_index
#type_traits
#units
#unordered
#utility
#uuid
#variant
#variant2
#vmd
dk_sublibrary(boost wave)
#winapi
#xpressive
#yap
#)

if(STATIC)
foreach(lib ${BOOST_LIBS})
	#DKSET(boost_${lib} 1)
	if(NOT boost_all)
		DKSET(BOOST_WITH ${BOOST_WITH} --with-${lib})
	endif()
endforeach()

DKSET(boost_fiber_nolib 1)
DKSET(boost_graph_parallel_nolib 1)
DKSET(boost_headers_nolib 1)
DKSET(boost_math_nolib 1)
DKSET(boost_mpi_nolib 1)
DKSET(boost_python_nolib 1)
DKSET(boost_test_nolib 1)
DKSET(boost_stacktrace_nolib 1)
foreach(lib ${BOOST_LIBS})
	if(lib AND boost_${lib} AND NOT boost_${lib}_nolib)
		WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.lib)
		WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.lib)
		WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.lib)
		WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.lib)
		APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
		LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
		RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
		ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${lib}.a)
		ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${lib}.a)
	endif()
endforeach()


### COMPILE ###
WIN32_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2.exe)
	WIN32_COMMAND("bootstrap.bat vc143")
endif()
WIN32_DEBUG_COMMAND(b2 toolset=msvc-14.3 address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN32_RELEASE_COMMAND(b2 toolset=msvc-14.3 address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


WIN64_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2.exe)
	WIN32_COMMAND("bootstrap.bat vc143")
endif()
WIN64_DEBUG_COMMAND(b2 toolset=msvc-14.2 address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN64_RELEASE_COMMAND(b2 toolset=msvc-14.2 address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


MAC32_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2)
	MAC32_COMMAND(./bootstrap.sh)
endif()
MAC32_DEBUG_COMMAND(./b2 toolset=darwin address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC32_RELEASE_COMMAND(./b2 toolset=darwin address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


MAC64_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2)
	MAC64_COMMAND(./bootstrap.sh)
endif()
MAC64_DEBUG_COMMAND(./b2 toolset=darwin address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
MAC64_RELEASE_COMMAND(./b2 toolset=darwin address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


LINUX32_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2)
	LINUX32_COMMAND(./bootstrap.sh)
endif()
LINUX32_DEBUG_COMMAND(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX32_RELEASE_COMMAND(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

LINUX64_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2)
	LINUX64_COMMAND(sudo ./bootstrap.sh)
endif()
LINUX64_DEBUG_COMMAND(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
LINUX64_RELEASE_COMMAND(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


RASPBERRY32_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2)
	RASPBERRY32_COMMAND(./bootstrap.sh)
endif()
RASPBERRY32_DEBUG_COMMAND(./b2 toolset=gcc address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY32_RELEASE_COMMAND(./b2 toolset=gcc address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

RASPBERRY64_PATH(${BOOST})
if(NOT EXISTS ${BOOST}/b2)
	RASPBERRY64_COMMAND(./bootstrap.sh)
endif()
RASPBERRY64_DEBUG_COMMAND(./b2 toolset=gcc address-model=64 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
RASPBERRY64_RELEASE_COMMAND(./b2 toolset=gcc address-model=64 variant=release link=static threading=multi runtime-debugging=off runtime-link=static --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


ANDROID_PATH(${BOOST})
ANDROID_MSYS(./SetupAndroid.sh)


ANDROID32_DEBUG_COMMAND(
	setx NDK_ROOT ${ANDROIDNDK} &&
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
	setx NDK_ROOT ${ANDROIDNDK} &&
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
	setx NDK_ROOT ${ANDROIDNDK} &&
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
	setx NDK_ROOT ${ANDROIDNDK} &&
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

endif(STATIC)


### TODO
if(SHARED)

#if(boost_filesystem)
#	WIN32_DEBUG_LIB(${BOOST}/${OS}/lib/boost_filesystem.lib)
#	WIN32_RELEASE_LIB(${BOOST}/${OS}/lib/boost_filesystem.lib)
#endif()

#if(boost_system)
#	WIN32_DEBUG_LIB(${BOOST}/${OS}/lib/boost_system.lib)
#	WIN32_RELEASE_LIB(${BOOST}/${OS}/lib/boost_system.lib)
#endif()

#WIN_PATH(${BOOST})
#WIN32_COMMAND(bootstrap.bat)
#WIN_COMMAND(b2 toolset=msvc-14.0 link=shared variant=debug runtime-debugging=on runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
#WIN_COMMAND(b2 toolset=msvc-14.0 link=shared variant=release runtime-debugging=off runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})

endif(SHARED)
