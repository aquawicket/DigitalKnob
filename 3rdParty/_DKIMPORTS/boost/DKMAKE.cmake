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

if(STATIC)

DKSET(BOOST_LIBS
#accumulators
#algorithm
#align
#any
#array
#asio
#assert
#assign
atomic
#beast
#bimap
#bind
#callable_traits
chrono
#circular_buffer
#compatibility
#compute
#concept_check
#config
container
#container_hash
context
contract
#conversion
#convert
#core
coroutine
#coroutine2
#crc
date_time
#detail
#dll
#dynamic_bitset
#endian
exception
#fiber
filesystem
#flyweight
#foreach
#format
#function
#functional
#function_types
#fusion
#geometry
#gil
graph
#graph_parallel
#hana
#headers
#heap
#histogram
#hof
#icl
#integer
#interprocess
#intrusive
#io
iostreams
#iterator
json
#lambda
#lexical_cast
locale
#local_function
#lockfree
log
#logic
#math
#metaparse
#move
#mp11
mpi
#mpl
#msm
#multiprecision
#multi_array
#multi_index
nowide
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
program_options
#property_map
#property_tree
#proto
#ptr_container
python
#qvm
random
#range
#ratio
#rational
regex
#safe_numerics
#scope_exit
serialization
#signals2
#smart_ptr
#sort
#spirit
stacktrace
#statechart
#static_assert
#static_string
#stl_interfaces
system
test
thread
#throw_exception
timer
#tokenizer
#tti
#tuple
#typeof
type_erasure
#type_index
#type_traits
#units
#unordered
#utility
#uuid
#variant
#variant2
#vmd
wave
#winapi
#xpressive
#yap
)



DKSET(BOOST_ALL 1)
foreach(item ${BOOST_LIBS})
	if(item)
	if(BOOST_ALL OR boost_${item})
		WIN32_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${item}.lib)
		WIN32_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${item}.lib)
		WIN64_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${item}.lib)
		WIN64_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${item}.lib)
		APPLE_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${item}.a)
		APPLE_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${item}.a)
		LINUX_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${item}.a)
		LINUX_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${item}.a)
		RASPBERRY_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${item}.a)
		RASPBERRY_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${item}.a)
		ANDROID_DEBUG_LIB(${BOOST}/${OS}/${DEBUG_DIR}/lib/libboost_${item}.a)
		ANDROID_RELEASE_LIB(${BOOST}/${OS}/${RELEASE_DIR}/lib/libboost_${item}.a)
		DKSET(BOOST_WITH ${BOOST_WITH} --with-${item})
	endif()
	endif()
endforeach()


### COMPILE ###
WIN32_PATH(${BOOST})
WIN32_COMMAND("bootstrap.bat vc143")
WIN32_DEBUG_COMMAND(b2 toolset=msvc-14.3 address-model=32 variant=debug link=static threading=multi runtime-debugging=on runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} --build-dir=${BOOST}/${OS}/${DEBUG_DIR} --stagedir=${BOOST}/${OS}/${DEBUG_DIR})
WIN32_RELEASE_COMMAND(b2 toolset=msvc-14.3 address-model=32 variant=release link=static threading=multi runtime-debugging=off runtime-link=static define=BOOST_ALL_NO_LIB --layout=system ${BOOST_WITH} --build-dir=${BOOST}/${OS}/${RELEASE_DIR} --stagedir=${BOOST}/${OS}/${RELEASE_DIR})


WIN64_PATH(${BOOST})
WIN64_COMMAND("bootstrap.bat vc143")
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
LINUX64_COMMAND(sudo ./bootstrap.sh)
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
