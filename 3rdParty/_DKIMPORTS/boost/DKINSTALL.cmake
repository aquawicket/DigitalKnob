#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


# https://github.com/boostorg/boost
# https://www.boost.org/
# https://www.boost.org/doc/libs/1_76_0/tools/build/doc/html/index.html - B2 User Manual - 1.76.0
# https://github.com/LibCMaker/LibCMaker#readme
# https://versaweb.dl.sourceforge.net/project/boost/boost/1.78.0/boost_1_78_0.zip
# https://sourceforge.net/projects/boost/files/boost/1.78.0/boost_1_78_0.zip
# https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.zip
#
# Debugging: When calling b2 to compile the boost libraries, you can use the -q flag to make it stop at the first error.
# Notes: abi=aapcs and binary-format=elf were added to android build to supress "No best alternative for libs/context/build/asm_sources"


if(Android)
	dk_depend(android-ndk)	#version 21e or newer required
	dk_validate(MSYS2 "dk_depend(msys2)")
endif()

#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(BOOST $ENV{DK3RDPARTY_DIR}/boost_1_78_0)
#dk_import(https://github.com/boostorg/boost.git)
dk_import(https://versaweb.dl.sourceforge.net/project/boost/boost/1.78.0/boost_1_78_0.zip PATCH)



### DKPLUGINS LINK ###
#dk_define(HAVE_Boost)
dk_define(BOOST_ALL_NO_LIB=1)
dk_define(BOOST_REGEX_DYN_LINK=1)
dk_include("${BOOST}")
dk_linkDir("${BOOST.Debug_Dir}/lib")
dk_linkDir("${BOOST.Release_Dir}/lib")

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
dk_set(boost_stacktrace_nolib 1)
dk_set(boost_test_nolib 1)
if(Mac)
	dk_removeTarget(boost json)
	dk_removeTarget(boost locale)
	dk_removeTarget(boost nowide)
endif()
if(Linux)
	dk_removeTarget(boost python)
endif()
if(Raspberry)
	dk_removeTarget(boost python)
endif()
if(Android)
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
		if(MSVC AND Windows)
			dk_libDebug("${BOOST.Debug_Dir}/lib/libboost_${lib}.lib")
			dk_libRelease("${BOOST.Release_Dir}/lib/libboost_${lib}.lib")
		else()
			dk_libDebug("${BOOST.Debug_Dir}/lib/libboost_${lib}.a")
			dk_libRelease("${BOOST.Release_Dir}/lib/libboost_${lib}.a")
		endif()
	endif()
endforeach()


### 3RDPARTY LINK ###
dk_set(BOOST_CMAKE -DBOOST_ROOT=${BOOST} -DBOOST_LIBRARYDIR=${BOOST.Tuple_Dir}/lib) #-DBoost_INCLUDE_DIR=${BOOST})


### GENERATE ###
dk_chdir("${BOOST}")
if(MSVC)
	if(NOT EXISTS "${BOOST}/b2.exe")
		if(Windows_Host)
			dk_exec("${BOOST}/bootstrap.bat" vc143)
		endif()
	endif()
else()
	if(NOT EXISTS "${BOOST}/b2")
		if(Unix)
			dk_exec("${BOOST}/bootstrap.sh")
		endif()
	endif()
endif()


### COMPILE ###
if(Android_Arm32_Debug)
	dk_exec("${BOOST}/SetupAndroid.sh")
	dk_exec(
		#setx NDK_ROOT ${ANDROID_NDK} &&
		"${BOOST}/b2.exe"
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
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir}
		${BOOST_WITH}
		${BOOST_WITHOUT}
		abi=aapcs
		binary-format=elf)
elseif(Android_Arm32_Release)
	dk_exec(
		#setx NDK_ROOT ${ANDROID_NDK} &&
		"${BOOST}/b2.exe"
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
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir}
		${BOOST_WITH}
		${BOOST_WITHOUT}
		abi=aapcs
		binary-format=elf)
elseif(Android_Arm64_Debug)
	dk_exec(
		#setx NDK_ROOT ${ANDROID_NDK} &&
		"${BOOST}/b2.exe"
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
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir}
		${BOOST_WITH}
		${BOOST_WITHOUT}
		abi=aapcs
		binary-format=elf)
elseif(Android_Arm64_Release)
	dk_exec(
		#setx NDK_ROOT ${ANDROID_NDK} &&
		"${BOOST}/b2.exe"
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
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir}
		${BOOST_WITH}
		${BOOST_WITHOUT}
		abi=aapcs
		binary-format=elf)
elseif(Iossim_X86_64_Debug)
	dk_exec("${BOOST}/b2"
		toolset=darwin address-model=64
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}) #--build-dir=${BOOST.Debug_Dir} --stagedir=${BOOST.Debug_Dir}
elseif(Iossim_X86_64_Release)
	dk_exec("${BOOST}/b2"
		toolset=darwin
		address-model=64
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}) #--build-dir=${BOOST.Release_Dir} --stagedir=${BOOST.Release_Dir}
elseif(Linux_X86_Debug)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=32
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Linux_X86_Release)
	dk_exec("${BOOST}/b2"
		toolset=gcc 
		address-model=32 
		variant=release 
		link=static 
		threading=multi 
		runtime-debugging=off 
		runtime-link=static 
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Linux_X86_64_Debug)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=64
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Linux_X86_64_Release)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=64
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Mac_X86_Debug)
	dk_exec("${BOOST}/b2"
		toolset=darwin
		address-model=32
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Mac_X86_Release)
	dk_exec("${BOOST}/b2"
		toolset=darwin
		address-model=32
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Mac_X86_64_Debug)
	dk_exec("${BOOST}/b2"
		toolset=darwin
		address-model=64
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Mac_X86_64_Release)
	dk_exec("${BOOST}/b2"
		toolset=darwin
		address-model=64
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Raspberry_Arm32_Debug)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=32
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Raspberry_Arm32_Release)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=32
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Raspberry_Arm64_Debug)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=64
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Raspberry_Arm64_Release)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		address-model=64
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Windows_X86_Debug AND MSVC)
	dk_exec("${BOOST}/b2.exe"
		toolset=msvc-14.3
		address-model=32
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		define=BOOST_ALL_NO_LIB
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Windows_X86_Debug AND MINGW)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		target-os=windows
		architecture=x86
		address-model=64
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Windows_X86_Release AND MSVC)
	dk_exec("${BOOST}/b2.exe"
		toolset=msvc-14.3
		address-model=32
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		define=BOOST_ALL_NO_LIB
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Windows_X86_64_Debug)
	dk_exec("${BOOST}/b2.exe"
		toolset=msvc-14.3
		address-model=64
		variant=debug
		link=static
		threading=multi
		runtime-debugging=on
		runtime-link=static
		define=BOOST_ALL_NO_LIB
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Debug_Dir}
		--stagedir=${BOOST.Debug_Dir})
elseif(Windows_X86_64_Release AND MSVC)
	dk_exec("${BOOST}/b2"
		toolset=msvc-14.3
		address-model=64
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		define=BOOST_ALL_NO_LIB
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
elseif(Windows_X86_64_Release AND MINGW)
	dk_exec("${BOOST}/b2"
		toolset=gcc
		target-os=windows
		architecture=x86
		address-model=64
		variant=release
		link=static
		threading=multi
		runtime-debugging=off
		runtime-link=static
		--layout=system
		${BOOST_WITH}
		${BOOST_WITHOUT}
		--build-dir=${BOOST.Release_Dir}
		--stagedir=${BOOST.Release_Dir})
endif()
endif(STATIC)


### TODO
if(SHARED)

#if(boost_filesystem)
#	Windows_X86_dk_libDebug(${BOOST}/${Target_Tuple}/lib/boost_filesystem.lib)
#	Windows_X86_dk_libRelease(${BOOST}/${Target_Tuple}/lib/boost_filesystem.lib)
#endif()

#if(boost_system)
#	Windows_X86_dk_libDebug(${BOOST}/${Target_Tuple}/lib/boost_system.lib)
#	Windows_X86_dk_libRelease(${BOOST}/${Target_Tuple}/lib/boost_system.lib)
#endif()

#if(Windows)
#	dk_chdir(${BOOST})
#	dk_exec(${BOOST}/bootstrap.bat)
#	dk_exec(${BOOST}/b2 toolset=msvc-14.0 link=shared variant=debug runtime-debugging=on runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST.Debug_Dir} --stagedir=${BOOST.Debug_Dir})
#	dk_exec(${BOOST}/b2 toolset=msvc-14.0 link=shared variant=release runtime-debugging=off runtime-link=shared --threading=multi --layout=system --build-dir=${BOOST.Release_Dir} --stagedir=${BOOST.Release_Dir})
#endif()

endif(SHARED)
