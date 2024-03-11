# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")

# Reference docs
# Get the definition of any shell command		https://explainshell.com 
# Clang command line argument reference			https://clang.llvm.org/docs/ClangCommandLineReference.html
# Cross-compilation using Clang					https://clang.llvm.org/docs/CrossCompilation.html
# GCC Options Controlling C++ Dialect			https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html
# GCC ARM Options								https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
# Getting Started with the LLVM System			https://llvm.org/docs/GettingStarted.html
# How To Cross-Compile Clang/LLVM				https://llvm.org/docs/HowToCrossCompileLLVM.html
# GCC flags on RPi4								https://forums.raspberrypi.com/viewtopic.php?t=244095
# compile LLVM with enabling RTTI, ABI 11		https://bibouh123.wordpress.com/2014/10/13/compile-llvm-with-enabling-rtti/
# Chromium CMakeLists.txt						https://chromium.googlesource.com/external/github.com/google/crc32c/+/refs/tags/1.0.5/CMakeLists.txt
# Visual Studio Exception handling model		https://docs.microsoft.com/en-us/cpp/build/reference/eh-exception-handling-model?view=msvc-170
# Difference between Clang LLVM GCC G++			https://stackoverflow.com/a/24836566/688352
# CRT and C++ STL .lib files 					https://docs.microsoft.com/en-us/cpp/c-runtime-library/crt-library-features?view=msvc-170
# Get started with the NDK						https://developer.android.com/ndk/guides
# target XP										https://tedwvc.wordpress.com/2014/01/01/how-to-target-xp-with-vc2012-or-vc2013-and-continue-to-use-the-windows-8-x-sdk
# GCC optimizations								https://gcc.gnu.org/onlinedocs/gcc-3.4.6/gcc/Optimize-Options.html
# LLVM optimizations							https://www.incredibuild.com/blog/compiling-with-clang-optimization-flags
# MSVC optimizations							https://learn.microsoft.com/en-us/cpp/build/reference/o-options-optimize-code?view=msvc-170


# Target Operating Systems
# https://en.wikipedia.org/wiki/Comparison_of_operating_systems
# android
# ios
# linux
# macos
# raspberry
# windows

# CPU Architectures
# https://en.wikipedia.org/wiki/Comparison_of_instruction_set_architectures
# x86
# x86_64
# arm32
# arm64

# C/C++ Compilers
# https://en.wikipedia.org/wiki/List_of_compilers#C_compilers
# https://en.wikipedia.org/wiki/List_of_compilers#C++_compilers
# clang
# gcc
# msvc

# Javascript Engines
# https://en.wikipedia.org/wiki/List_of_ECMAScript_engines
# duktape
# v8
         
# helpful terminal commands
# lscpu                                     see details about the cpu                 https://explainshell.com/explain?cmd=lscpu
# uname -a                                  system identifier                         https://explainshell.com/explain?cmd=uname+-a
# gcc -c -Q -march=native --help=target     target specific compiler gcc flags        https://explainshell.com/explain?cmd=gcc+-c+-Q+-march%3Dnative+--help%3Dtarget
# gcc --version                             the version of gcc on the host machine    https://explainshell.com/explain?cmd=gcc+--version
# gcc --help                                general gcc help                          https://explainshell.com/explain?cmd=gcc+--help
# clang --version                           the version of clang on the host machine  https://explainshell.com/explain?cmd=clang+--version 
# clang--help                               general clang help                        https://explainshell.com/explain?cmd=clang+--help
# gcc-fpu                                   ARM processor floating point math         https://explainshell.com/explain?cmd=gcc+-fpu

# common flags for compilers
#										GCC					CLANG/LLVM			MSVC													NOTES
# Enable runtime type information		-frtti				-frtti				/GR                                                         
# Disable runtime type information		-fno-rtti			-fno-rtti			/GR-                                                         
# Standard C++ exception handling		-fexceptions		-fexceptions		/EHsc													#https://stackoverflow.com/a/4574319/688352
# No Exceptions							-fno-exceptions		-fno-exceptions		/D_HAS_EXCEPTIONS=0										#https://stackoverflow.com/a/65513682/688352
# Use address sanatizer					-fsanitize=address	-fsanitize=address	/fsanitize=address										incompatable with /RTC1 
# Suppress Startup Banner														/nologo     
# Enable updated __cplusplus macro												/Zc:__cplusplus       
# Precompiled Header Memory Limit												/Zm<factor>												<factor> = memory size  EXAMPLE: /Zm500  
# No Experimental filesystem warning											/D_SILENCE_EXPERIMENTAL_FILESYSTEM_DEPRECATION_WARNING
# Enable CRT Secure functions extension											/D__STDC_WANT_LIB_EXT1__
# supress CRT Secure function warnings											/D_CRT_SECURE_NO_WARNINGS
# precompiled headers															/Yu<file>												<file> = file name  EXAMPLE: /Yustdafx.h																


############ CORE DEPENDENCIES ############
if(MSVC)
	include(${DKIMPORTS_DIR}/visualstudio/DKMAKE.cmake)
endif()
if(MINGW)
	#dk_set(PROJECT_INCLUDE_DKPLUGINS 0)
	include(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
	include(${DKIMPORTS_DIR}/make/DKMAKE.cmake)
	include(${DKIMPORTS_DIR}/gdb/DKMAKE.cmake)
	unset(CMAKE_IMPORT_LIBRARY_SUFFIX)
endif()
if(MINGW32 OR MINGW64)
	include(${DKIMPORTS_DIR}/gcc/DKMAKE.cmake)
endif()
if(CLANG32 OR CLANG64 OR CLANGARM64 OR UCRT64)
	include(${DKIMPORTS_DIR}/clang/DKMAKE.cmake)
endif()
if(XCODE)
	include(${DKIMPORTS_DIR}/xcode/DKMAKE.cmake)
endif()
if(LINUX_HOST)
	include(${DKIMPORTS_DIR}/gcc/DKMAKE.cmake)
	include(${DKIMPORTS_DIR}/gdb/DKMAKE.cmake)
endif()
if(ANDROID)
	include(${DKIMPORTS_DIR}/android-ndk/DKMAKE.cmake)
endif()
if(EMSCRIPTEN)
	include(${DKIMPORTS_DIR}/emsdk/DKMAKE.cmake)
endif()
include(${DKIMPORTS_DIR}/cmake/DKMAKE.cmake)




### User Friendly Options ###
dk_set(BUILD_SHARED_LIBS				OFF)
dk_set(BUILD_STATIC_LIBS				ON)
dk_set(ENABLE_EXCEPTIONS				ON)    
dk_set(ENABLE_RTTI						ON)
dk_set(POSITION_INDEPENDENT_CODE 		ON)
dk_set(POSITION_INDEPENDENT_EXECUTABLE 	ON)                                        
dk_set(WARNINGS_AS_ERRORS				OFF)
dk_set(WARNING_4244						OFF)	# /wd4244 - Warning: possible loss of data 
dk_set(WARNING_5105						OFF)	# /wd5105 - macro producing defined is undefined behaviour
dk_set(WARNING_LEVEL 					4)
#dk_set(STATIC							ON)
#dk_set(SHARED							OFF)


dk_append		(DKCMAKE_FLAGS -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS})
dk_append		(DKCMAKE_FLAGS -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS})
if(${BUILD_SHARED_LIBS})
	dk_append	(DKCONFIGURE_FLAGS --enable-shared)
else()
	dk_append	(DKCONFIGURE_FLAGS --disable-shared)
endif()
if(${BUILD_STATIC_LIBS})
	dk_append	(DKCONFIGURE_FLAGS --enable-static)
else()
	dk_append	(DKCONFIGURE_FLAGS --disable-static)
endif()

if(MSVC)
	WIN_dk_append(CMAKE_C_FLAGS_DEBUG			/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
	WIN_dk_append(CMAKE_C_FLAGS_RELEASE			/MT /O2 /Ob2 /DNDEBUG)
	WIN_dk_append(CMAKE_CXX_FLAGS_DEBUG			/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
	WIN_dk_append(CMAKE_CXX_FLAGS_RELEASE		/MT /O2 /Ob2 /DNDEBUG)
else()
	dk_append(CMAKE_C_FLAGS_DEBUG				-DDEBUG -D_DEBUG -g)
	dk_append(CMAKE_C_FLAGS_RELEASE				-O3 -DNDEBUG)
	
	dk_append(CMAKE_CXX_FLAGS_DEBUG				-DDEBUG -D_DEBUG -g)
	dk_append(CMAKE_CXX_FLAGS_RELEASE			-O3 -DNDEBUG)
endif()
dk_set(DKCONFIGURE_CFLAGS_DEBUG					-DDEBUG -D_DEBUG -g)
dk_set(DKCONFIGURE_CFLAGS_RELEASE				-O3 -DNDEBUG)
dk_set(DKCONFIGURE_CXXFLAGS_DEBUG				-DDEBUG -D_DEBUG -g)
dk_set(DKCONFIGURE_CXXFLAGS_RELEASE				-O3 -DNDEBUG)

###### POSITION_INDEPENDENT_CODE ######
# https://stackoverflow.com/a/3544211/688352   -fPIC vs -fpic
# https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-fPIC
if(WIN_HOST)
	dk_set(POSITION_INDEPENDENT_CODE OFF)
endif()
if(POSITION_INDEPENDENT_CODE)
	if(MSVC AND WIN)
		
	else()
		dk_append(CMAKE_C_FLAGS -fPIC)
		dk_append(CMAKE_CXX_FLAGS -fPIC)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fPIC) 
	dk_append(DKCONFIGURE_CXXFLAGS -fPIC) 
else()	
	if(MSVC AND WIN)
		
	else()
		dk_append(CMAKE_C_FLAGS -fno-pic)
		dk_append(CMAKE_CXX_FLAGS -fno-pic)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fno-pic) 
	dk_append(DKCONFIGURE_CXXFLAGS -fno-pic) 
endif()

###### POSITION_INDEPENDENT_EXECUTABLE ######
# https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-fpie
if(POSITION_INDEPENDENT_EXECUTABLE)
	if(MSVC AND WIN)
	
	else()
		dk_append(CMAKE_C_FLAGS -fPIE)
		dk_append(CMAKE_CXX_FLAGS -fPIE)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fPIE)
	dk_append(DKCONFIGURE_CXXFLAGS -fPIE)
else()
	if(MSVC AND WIN)
	
	else()
		dk_append(CMAKE_C_FLAGS -fno-pie)
		dk_append(CMAKE_CXX_FLAGS -fno-pie)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fno-pie) 
	dk_append(DKCONFIGURE_CXXFLAGS -fno-pie) 
endif()

###### RUN-TIME TYPE IDENTIFICATION ######
if(ENABLE_RTTI)
	if(MSVC AND WIN)
		dk_append(CMAKE_CXX_FLAGS /GR)
	else()
		dk_append(CMAKE_CXX_FLAGS -frtti)
	endif()
	dk_append(DKCONFIGURE_CXXFLAGS -frtti)
else()
	if(MSVC AND WIN)
		dk_append(CMAKE_C_FLAGS /GR-)
		dk_append(CMAKE_CXX_FLAGS /GR-)
	else()
		# https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html#index-fno-rtti
		dk_append(CMAKE_C_FLAGS -fno-rtti)
		dk_append(CMAKE_CXX_FLAGS -fno-rtti)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fno-rtti) 
	dk_append(DKCONFIGURE_CXXFLAGS -fno-rtti)
endif()

###### EXCEPTIONS ######
if(ENABLE_EXCEPTIONS)
	if(MSVC AND WIN)
		dk_append(CMAKE_C_FLAGS /EHsc)
		dk_append(CMAKE_CXX_FLAGS /EHsc)
	else()
		dk_append(CMAKE_C_FLAGS -fexceptions)
		dk_append(CMAKE_CXX_FLAGS -fexceptions)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fexceptions) 
	dk_append(DKCONFIGURE_CXXFLAGS -fexceptions)
else()
	if(MSVC AND WIN)
		dk_append(CMAKE_C_FLAGS /D_HAS_EXCEPTIONS=0)
		dk_append(CMAKE_CXX_FLAGS /D_HAS_EXCEPTIONS=0)
	else()
		dk_append(CMAKE_C_FLAGS -fno-exceptions)
		dk_append(CMAKE_CXX_FLAGS -fno-exceptions)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fno-exceptions) 
	dk_append(DKCONFIGURE_CXXFLAGS -fno-exceptions)
endif()





#### Android arm32
if(ANDROID_ARM32)
	dk_set(CMAKE_GENERATOR					${ANDROID_GENERATOR})
	dk_set(CMAKE_TOOLCHAIN_FILE				${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
	dk_set(ANDROID_PLATFORM					${ANDROID_API})
	dk_set(CMAKE_MAKE_PROGRAM				${ANDROID_MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${ANDROID_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${ANDROID_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_ARM32 -std=c17)
	dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM32 -std=c++1z)
	
	dk_set(DKCONFIGURE_CC					${ANDROID_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${ANDROID_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID_ARM32 -std=c17)
	dk_append(DKCONFIGURE_CXXFLAGS			-DANDROID -DANDROID_ARM32 -std=c++1z)
	
	dk_append(DKCMAKE_FLAGS
		-DANDROID_ABI=armeabi-v7a
		"-DANDROID_CPP_FEATURES=rtti exceptions"
		-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
		-DANDROID_NDK=${ANDROID_NDK}
		-DANDROID_PLATFORM=${ANDROID_API}
		-DANDROID_STL=c++_static
		-DANDROID_STL_FORCE_FEATURES=1
		-DANDROID_TOOLCHAIN=clang
		-DCMAKE_ANDROID_STL_TYPE=c++_static
	)
endif()

### Android arm64
if(ANDROID_ARM64)
	dk_set(CMAKE_GENERATOR					${ANDROID_GENERATOR})
	dk_set(CMAKE_TOOLCHAIN_FILE				${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
	dk_set(CMAKE_MAKE_PROGRAM				${ANDROID_MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${ANDROID_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${ANDROID_CXX_COMPILER})
	dk_set(CMAKE_ANDROID_STL_TYPE			c++_static)
	dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_ARM64 -std=c17)
	dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM64 -std=c++1z)
	
	dk_set(DKCONFIGURE_CC					${ANDROID_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${ANDROID_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID_ARM64 -std=c17)
	dk_append(DKCONFIGURE_CXXFLAGS			-DANDROID -DANDROID_ARM64 -std=c++1z)
	

	dk_set(ANDROID_ABI 						arm64-v8a)
	dk_set(ANDROID_CPP_FEATURES				rtti exceptions)
	dk_set(ANDROID_NATIVE_API_LEVEL			${ANDROID_API})
	dk_set(ANDROID_NDK						${ANDROID_NDK})
	dk_set(ANDROID_PLATFORM					${ANDROID_API})
	dk_set(ANDROID_STL						c++_static)
	dk_set(ANDROID_STL_FORCE_FEATURES		1)
	dk_set(ANDROID_TOOLCHAIN				clang)
	
	dk_append(DKCMAKE_FLAGS 
		-DANDROID_ABI=arm64-v8a
		"-DANDROID_CPP_FEATURES=rtti exceptions"
		-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
		-DANDROID_NDK=${ANDROID_NDK}
		-DANDROID_PLATFORM=${ANDROID_API}
		-DANDROID_STL=c++_static
		-DANDROID_STL_FORCE_FEATURES=1
		-DANDROID_TOOLCHAIN=clang
		-DCMAKE_ANDROID_STL_TYPE=c++_static
	)
endif()

### Android x86
if(ANDROID_X86)
	dk_set(CMAKE_GENERATOR					${ANDROID_GENERATOR})
	dk_set(CMAKE_TOOLCHAIN_FILE				${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
	dk_set(ANDROID_PLATFORM					${ANDROID_API})
	dk_set(CMAKE_MAKE_PROGRAM				${ANDROID_MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${ANDROID_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${ANDROID_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_X86 -std=c17)
	dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_X86 -std=c++1z)
	
	dk_set(DKCONFIGURE_CC					${ANDROID_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${ANDROID_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID_X86 -std=c17)
	dk_append(DKCONFIGURE_CXXFLAGS			-DANDROID -DANDROID_X86 -std=c++1z)
	
	dk_append(DKCMAKE_FLAGS 
		-DANDROID_ABI=x86
		"-DANDROID_CPP_FEATURES=rtti exceptions"
		-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
		-DANDROID_NDK=${ANDROID_NDK}
		-DANDROID_PLATFORM=${ANDROID_API}
		-DANDROID_STL=c++_static
		-DANDROID_STL_FORCE_FEATURES=1
		-DANDROID_TOOLCHAIN=clang
		-DCMAKE_ANDROID_STL_TYPE=c++_static
	)
endif()

### Android x86_64
if(ANDROID_X86)
	dk_set(CMAKE_GENERATOR					${ANDROID_GENERATOR})
	dk_set(CMAKE_TOOLCHAIN_FILE				${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
	dk_set(ANDROID_PLATFORM					${ANDROID_API})
	dk_set(CMAKE_MAKE_PROGRAM				${ANDROID_MAKE_PROGRAM})
	dk_set(CMAKE_AR							${ANDROID_AR})
	dk_set(CMAKE_C_COMPILER					${ANDROID_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${ANDROID_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_X86_64 -std=c17)
	dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_X86_64 -std=c++1z)
	
	dk_set(DKCONFIGURE_CC					${ANDROID_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${ANDROID_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID_X86_64 -std=c17)
	dk_append(DKCONFIGURE_CXXFLAGS			-DANDROID -DANDROID_X86_64 -std=c++1z)
	
	dk_append(DKCMAKE_FLAGS 
		-DANDROID_ABI=x86_64
		"-DANDROID_CPP_FEATURES=rtti exceptions"
		-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
		-DANDROID_NDK=${ANDROID_NDK}
		-DANDROID_PLATFORM=${ANDROID_API}
		-DANDROID_STL=c++_static
		-DANDROID_STL_FORCE_FEATURES=1
		-DANDROID_TOOLCHAIN=clang
		-DCMAKE_ANDROID_STL_TYPE=c++_static
	)
endif()

### Emscripten ###
if(EMSCRIPTEN)
	dk_set(CMAKE_GENERATOR					${EMSCRIPTEN_GENERATOR})
	dk_set(CMAKE_TOOLCHAIN_FILE				${EMSCRIPTEN_TOOLCHAIN_FILE})
	dk_set(CMAKE_C_COMPILER					${EMSCRIPTEN_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${EMSCRIPTEN_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DEMSCRIPTEN -std=gnu11)
	dk_append(CMAKE_CXX_FLAGS				-DEMSCRIPTEN -std=gnu++17)
	
	dk_set(DKCONFIGURE_CC					${EMSCRIPTEN_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${EMSCRIPTEN_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DEMSCRIPTEN -std=gnu11)
	dk_append(DKCONFIGURE_CXXFLAGS			-DEMSCRIPTEN -std=gnu++17)
	
	dk_append(DKCMAKE_FLAGS					-DEMSCRIPTEN=ON)
endif()

### iOS arm32 - XCODE ###
if(IOS_ARM32)
	dk_set(CMAKE_GENERATOR					${XCODE_GENERATOR})
	dk_set(IOS_TOOLCHAIN_FILE				${IOS_TOOLCHAIN_FILE})
	dk_set(CMAKE_C_COMPILER					${XCODE_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DIOS -DIOS_ARM32 -std=c17 -x objective-c)
	dk_append(CMAKE_CXX_FLAGS				-DIOS -DIOS_ARM32 -std=c++17 -x objective-c++)

	dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
	dk_append(DKCONFIGURE_FLAGS				--host arm-apple-${IOS_DARWIN})
	dk_append(DKCONFIGURE_CFLAGS			-arch arm -DIOS -DIOS_ARM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
	dk_append(DKCONFIGURE_CXXFLAGS			-arch arm -DIOS -DIOS_ARM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
	
	dk_append(DKCMAKE_FLAGS					-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm)
	
endif()

### iOS_ARM64 - XCODE ###
if(IOS_ARM64)
	dk_set(CMAKE_GENERATOR					${XCODE_GENERATOR})
	dk_set(IOS_TOOLCHAIN_FILE				${IOS_TOOLCHAIN_FILE})
	dk_set(CMAKE_C_COMPILER					${XCODE_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DIOS -DIOS_ARM64 -std=c17 -x objective-c)
	dk_append(CMAKE_CXX_FLAGS				-DIOS -DIOS_ARM64 -std=c++17 -x objective-c++)
	
	dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
	dk_append(DKCONFIGURE_FLAGS				--host arm64-apple-${IOS_DARWIN})
	dk_append(DKCONFIGURE_CFLAGS			-arch arm64 -DIOS -DIOS_ARM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
	dk_append(DKCONFIGURE_CXXFLAGS			-arch arm64 -DIOS -DIOS_ARM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
	
	dk_append(DKCMAKE_FLAGS					-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS64 -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm64)
endif()

### iOS Simulator x86 - XCODE ###
if(IOSSIM_X86)
	dk_set(CMAKE_GENERATOR					${XCODE_GENERATOR})
	dk_set(IOS_TOOLCHAIN_FILE				${IOS_TOOLCHAIN_FILE})
	dk_set(CMAKE_C_COMPILER					${XCODE_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DIOS -DIOSSIM -DIOSSIM_X86 -std=c17 -x objective-c)
	dk_append(CMAKE_CXX_FLAGS				-DIOS -DIOSSIM -DIOSSIM_X86 -std=c++17 -x objective-c++)
	
	dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
	dk_append(DKCONFIGURE_FLAGS				--host i686-apple-${IOS_DARWIN})
	dk_append(DKCONFIGURE_CFLAGS			-arch i686 -DIOS -DIOSSIM -DIOSSIM_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
	dk_append(DKCONFIGURE_CXXFLAGS			-arch i686 -DIOS -DIOSSIM -DIOSSIM_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
	
	dk_append(DKCMAKE_FLAGS					-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=SIMULATOR -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=i686)
endif()

### iOS Simulator x86_64 - XCODE ###
if(IOSSIM_X86_64)
	dk_set(CMAKE_GENERATOR					${XCODE_GENERATOR})
	dk_set(IOS_TOOLCHAIN_FILE				${IOS_TOOLCHAIN_FILE})
	dk_set(CMAKE_C_COMPILER					${XCODE_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DIOS -DIOSSIM -DIOSSIM_X86_64 -std=c17 -x objective-c)
	dk_append(CMAKE_CXX_FLAGS				-DIOS -DIOSSIM -DIOSSIM_X86_64 -std=c++17 -x objective-c++)
	
	dk_set(DKCONFIGURE_CC					${IOS_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${IOS_CXX_COMPILER})
	dk_append(DKCONFIGURE_FLAGS				--host x86_64-apple-${IOS_DARWIN})
	dk_append(DKCONFIGURE_CFLAGS			-arch x86_64 -DIOS -DIOSSIM -DIOSSIM_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
	dk_append(DKCONFIGURE_CXXFLAGS			-arch x86_64 -DIOS -DIOSSIM -DIOSSIM_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
	
	dk_append(DKCMAKE_FLAGS					-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=SIMULATOR64 -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=x86_64)
endif()

### Linux x86 ###
if(LINUX_X86)
	dk_set(CMAKE_GENERATOR					"Unix Makefiles")
	dk_set(CMAKE_C_COMPILER					${GCC_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=i686 -DLINUX -DLINUX_X86 -std=gnu11)
	dk_append(CMAKE_CXX_FLAGS				-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs)
	
	dk_set(DKCONFIGURE_CC					${GCC_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${GCC_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-march=i686 -DLINUX -DLINUX_X86 -std=gnu11)
	dk_append(DKCONFIGURE_CXXFLAGS			-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs)
endif()

#### Linux x86_64 ###
if(LINUX_X86_64)
	dk_set(CMAKE_GENERATOR					"Unix Makefiles")
	dk_set(CMAKE_C_COMPILER					${GCC_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11)
	dk_append(CMAKE_CXX_FLAGS				-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
	
	dk_set(DKCONFIGURE_CC					${GCC_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${GCC_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11)
	dk_append(DKCONFIGURE_CXXFLAGS			-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
endif()

### Mac x86 - XCODE ###
if(MAC_X86)
	dk_set(CMAKE_GENERATOR					${XCODE_GENERATOR})
	dk_set(CMAKE_C_COMPILER					${XCODE_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DMAC i686 -DMAC_X86 -std=c17 -x objective-c)
	dk_append(CMAKE_CXX_FLAGS				-DMAC i686 -DMAC_X86 -std=c++17 -x objective-c++)
	
	dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-arch i686 -DMAC -DMAC_X86 -std=c17) #-x objective-c) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
	dk_append(DKCONFIGURE_CXXFLAGS			-arch i686 -DMAC -DMAC_X86 -std=c++17) #-x objective-c++) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
	
	dk_append(DKCMAKE_FLAGS					-DCMAKE_OSX_ARCHITECTURES=x86)
endif()

### Mac x86_64 - XCODE ###
if(MAC_X86_64)
	dk_set(CMAKE_GENERATOR					${XCODE_GENERATOR})
	dk_set(CMAKE_C_COMPILER					${XCODE_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DMAC -DMAC_X86_64 -std=c17 -x objective-c)
	dk_append(CMAKE_CXX_FLAGS				-DMAC -DMAC_X86_64 -std=c++17 -x objective-c++)

	dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DMAC -DMAC_X86_64 -std=c17) #-x objective-c) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
	dk_append(DKCONFIGURE_CXXFLAGS			-DMAC -DMAC_X86_64 -std=c++17) #-x objective-c++) #https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
	
	dk_append(DKCMAKE_FLAGS					-DCMAKE_OSX_ARCHITECTURES=x86_64)
endif()

### Raspbery arm32 ###
if(RASPBERRY_ARM32)
	dk_set(CMAKE_GENERATOR					"Unix Makefiles")
	dk_set(CMAKE_C_COMPILER					${GCC_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11) 				#-march=armv7l
	dk_append(CMAKE_CXX_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs) 	#-march=armv7l 
	
	dk_set(DKCONFIGURE_CC					${GCC_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${GCC_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11) 				#-march=armv7l 
	dk_append(DKCONFIGURE_CXXFLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs) 	#-march=armv7l
endif()

### Raspbery arm64 ###
if(RASPBERRY_ARM64)
	dk_set(CMAKE_GENERATOR					"Unix Makefiles")
	dk_set(CMAKE_C_COMPILER					${GCC_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11) 				#-march=armv7l
	dk_append(CMAKE_CXX_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs) 	#-march=armv7l 
	
	dk_set(DKCONFIGURE_CC					${GCC_C_COMPILER})
	dk_set(DKCONFIGURE_CXX					${GCC_CXX_COMPILER})
	dk_append(DKCONFIGURE_CFLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11) 				#-march=armv7l 
	dk_append(DKCONFIGURE_CXXFLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs) 	#-march=armv7l
endif()

### Windows x86 - MSVC ###
if(WIN_X86 AND MSVC)
	dk_set(CMAKE_GENERATOR 					${VISUALSTUDIO_GENERATOR})
	dk_set(CMAKE_C_COMPILER					${VISUALSTUDIO_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${VISUALSTUDIO_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj) # /D_WIN32_WINNT=0x0600
	dk_append(CMAKE_CXX_FLAGS				/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) # /D_WIN32_WINNT=0x0600
endif()

### Windows x86 - MINGW32 ###
if(WIN_X86 AND MINGW32)
	dk_set(MSYSTEM MINGW32)
	dk_set(CMAKE_GENERATOR					${MSYS2_GENERATOR}) 
	dk_set(CMAKE_C_COMPILER					${GCC_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=i686 -DMSYSTEM=MINGW32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
	dk_append(CMAKE_CXX_FLAGS				-march=i686 -DMSYSTEM=MINGW32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
	#dk_append(DKCMAKE_EXE_LINKER_FLAGS		-s)
	
	dk_append(DKCONFIGURE_FLAGS				--build=i686-w64-mingw32)
	dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
	dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
endif()

### Windows x86 - CLANG32 ###
if(WIN_X86 AND CLANG32)
	dk_set(MSYSTEM CLANG32)
	dk_set(CMAKE_GENERATOR					${MSYS2_GENERATOR}) 
	dk_set(CMAKE_C_COMPILER					${CLANG_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${CLANG_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=i686 -DMSYSTEM=CLANG32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
	dk_append(CMAKE_CXX_FLAGS				-march=i686 -DMSYSTEM=CLANG32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
	#dk_append(DKCMAKE_EXE_LINKER_FLAGS		-s)
	
	dk_append(DKCONFIGURE_FLAGS				--build=i686-w64-mingw32)
	dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
	dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
endif()


### Windows x86_64 - MSVC ###
if(WIN_X86_64 AND MSVC)
	dk_set(CMAKE_C_COMPILER					${VISUALSTUDIO_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${VISUALSTUDIO_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X64 /D_WIN32_WINNT=0x0600
	dk_append(CMAKE_CXX_FLAGS				/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X64 /D_WIN32_WINNT=0x0600
endif()

### Windows x86_64 - MINGW64 ###
if(WIN_X86_64 AND MINGW64)
	dk_set(MSYSTEM MINGW64)
	dk_set(CMAKE_GENERATOR					${MSYS2_GENERATOR})
	dk_set(CMAKE_MAKE_PROGRAM				${MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${GCC_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17) # -D_WIN32_WINNT=0x0600
	dk_append(CMAKE_CXX_FLAGS				-march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17) # -D_WIN32_WINNT=0x0600
	#dk_append(CMAKE_EXE_LINKER_FLAGS		-s)
	
	dk_append(DKCONFIGURE_FLAGS				--build=x86_64-w64-mingw32)
	dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
	dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
endif()

### Windows x86_64 - CLANG64 ###
if(WIN_X86_64 AND CLANG64)
	dk_set(MSYSTEM CLANG64)
	dk_append(DKFLAGS 						-DMSYSTEM=CLANG64)
	dk_set(CMAKE_GENERATOR					${MSYS2_GENERATOR})
	dk_set(CMAKE_MAKE_PROGRAM				${MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${CLANG_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${CLANG_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=x86-64 -DMSYSTEM=CLANG64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17) # -D_WIN32_WINNT=0x0600
	dk_append(CMAKE_CXX_FLAGS				-march=x86-64 -DMSYSTEM=CLANG64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17) # -D_WIN32_WINNT=0x0600
	dk_append(CMAKE_EXE_LINKER_FLAGS		-s)
	
	dk_append(DKCONFIGURE_FLAGS				--build=x86_64-w64-mingw32)
	dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
	dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
endif()

### Windows x86_64 - UCRT64 ###
if(WIN_X86_64 AND UCRT64)
	dk_set(MSYSTEM UCRT64)
	dk_set(CMAKE_GENERATOR					${MSYS2_GENERATOR})
	dk_set(CMAKE_MAKE_PROGRAM				${MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${CLANG_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${CLANG_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=x86-64 -DMSYSTEM=UCRT64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17) # -D_WIN32_WINNT=0x0600
	dk_append(CMAKE_CXX_FLAGS				-march=x86-64 -DMSYSTEM=UCRT64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17) #-D_WIN32_WINNT=0x0600
	#dk_append(CMAKE_EXE_LINKER_FLAGS		-s)
	
	dk_append(DKCONFIGURE_FLAGS				--build=x86_64-w64-mingw32)
	dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
	dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
endif()

### Windows arm64 - CLANGARM64 ###
if(WIN_ARM64 AND CLANGARM64)
	dk_set(MSYSTEM CLANGARM64)
	dk_set(CMAKE_GENERATOR					${MSYS2_GENERATOR}) 
	dk_set(CMAKE_MAKE_PROGRAM				${MAKE_PROGRAM})
	dk_set(CMAKE_C_COMPILER					${CLANG_C_COMPILER})
	dk_set(CMAKE_CXX_COMPILER				${CLANG_CXX_COMPILER})
	dk_append(CMAKE_C_FLAGS					-march=aarch64 -DMSYSTEM=CLANGARM64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17) # -D_WIN32_WINNT=0x0600
	dk_append(CMAKE_CXX_FLAGS				-march=aarch64 -DMSYSTEM=CLANGARM64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17) # -D_WIN32_WINNT=0x0600
	#dk_append(CMAKE_EXE_LINKER_FLAGS		-s)
	
	dk_append(DKCONFIGURE_FLAGS				--build=aarch64-w64-mingw32)
	dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
	dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
endif()






######### Extra Flags and Settings #########
if(WARNINGS_AS_ERRORS)
	if(MSVC)
		WIN_dk_append	(CMAKE_C_FLAGS		/WX)
		WIN_dk_append	(CMAKE_CXX_FLAGS	/WX)
	else()
		dk_append		(CMAKE_C_FLAGS		-Werror)
		dk_append		(CMAKE_CXX_FLAGS	-Werror)
	endif()
endif()
if(WARNING_LEVEL)
	if(MSVC)
		WIN_dk_append	(CMAKE_C_FLAGS		/W${WARNING_LEVEL})
		WIN_dk_append	(CMAKE_CXX_FLAGS	/W${WARNING_LEVEL})
	endif()
endif()
if(WARNING_4244) # /wd4244 - Warning: possible loss of data 
	if(MSVC)
		WIN_dk_append	(CMAKE_C_FLAGS		/wd4244)
		WIN_dk_append	(CMAKE_CXX_FLAGS	/wd4244)
	endif()
endif()
if(WARNING_5105) # /wd5105 - macro producing defined is undefined behaviour
	if(MSVC)
		WIN_dk_append	(CMAKE_C_FLAGS		/wd5105)
		WIN_dk_append	(CMAKE_CXX_FLAGS	/wd5105)
	endif()
endif()




# GENERATOR			BUILD_DIR		OUTPUT_DIR
# -----------------------------------------------
# Visual Studio  	${OS}			${OS}/${TYPE}		
# XCODE			    ${OS}			${OS}/${TYPE} 
# MinGW Makefiles   ${OS}/${TYPE}	${OS}/${TYPE} 
# Unix Makefiles    ${OS}/${TYPE}   ${OS}/${TYPE}  
# ./configure       ${OS}/${TYPE}   ${OS}/${TYPE}

# https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#build-configurations

if(MULTI_CONFIG)
	dk_set		(CMAKE_BUILD_TYPE Debug Release)
	dk_set		(BUILD_DIR ${OS})
else()
	if(DEBUG)
		dk_set	(CMAKE_BUILD_TYPE Debug)
		dk_set	(BUILD_DIR ${OS}/${DEBUG_DIR})
	elseif(RELEASE)
		dk_set	(CMAKE_BUILD_TYPE Release)
		dk_set	(BUILD_DIR ${OS}/${RELEASE_DIR})
	endif()
endif()





############## Setup continued by cmake from here ##############
if(CMAKE_BUILD_TYPE)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
endif()
if(CMAKE_TOOLCHAIN_FILE)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})
endif()
if(CMAKE_MAKE_PROGRAM)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM})
endif()
if(CMAKE_AR)
	dk_append				(DKCMAKE_FLAGS		-DCMAKE_AR=${CMAKE_AR})
endif()
if(CMAKE_C_COMPILER)
	dk_append				(DKCMAKE_FLAGS		-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER})
endif()
if(CMAKE_CXX_COMPILER)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
endif()
if(CMAKE_C_FLAGS)
	string(REPLACE ";" " " CMAKE_C_FLAGS 		"${CMAKE_C_FLAGS}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS})
endif()
if(CMAKE_CXX_FLAGS)
	string(REPLACE ";" " " CMAKE_CXX_FLAGS 		"${CMAKE_CXX_FLAGS}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS})
endif()
if(CMAKE_C_FLAGS_DEBUG)
	string(REPLACE ";" " " CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG})
endif()
if(CMAKE_C_FLAGS_RELEASE)
	string(REPLACE ";" " " CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE})
endif()
if(CMAKE_CXX_FLAGS_DEBUG)
	string(REPLACE ";" " " CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_FLAGS_DEBUG=${CMAKE_CXX_FLAGS_DEBUG})
endif()
if(CMAKE_CXX_FLAGS_RELEASE)
	string(REPLACE ";" " " CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_FLAGS_RELEASE=${CMAKE_CXX_FLAGS_RELEASE})
endif()
if(CMAKE_EXE_LINKER_FLAGS)
	string(REPLACE ";" " " CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}")
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_EXE_LINKER_FLAGS=${CMAKE_EXE_LINKER_FLAGS})
endif()


if(DKCONFIGURE_CC)
	dk_append		(DKCONFIGURE_FLAGS CC=${DKCONFIGURE_CC})
endif()
if(DKCONFIGURE_CXX)
	dk_append		(DKCONFIGURE_FLAGS CXX=${DKCONFIGURE_CXX})
endif()
if(DKCONFIGURE_CFLAGS)
	string(REPLACE ";" " " DKCONFIGURE_CFLAGS "${DKCONFIGURE_CFLAGS}")
	dk_append		(DKCONFIGURE_FLAGS CFLAGS=${DKCONFIGURE_CFLAGS})
endif()
if(DKCONFIGURE_CXXFLAGS)
	string(REPLACE ";" " " DKCONFIGURE_CXXFLAGS "${DKCONFIGURE_CXXFLAGS}")
	dk_append		(DKCONFIGURE_FLAGS CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
endif()










###### Set DKCMAKE_BUILD variable ######
if(MSVC)
	ANDROID_ARM32_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A ARM ${DKCMAKE_FLAGS})
	ANDROID_ARM64_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A ARM64 ${DKCMAKE_FLAGS})
else()
	#ANDROID_ARM32_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	#ANDROID_ARM64_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	ANDROID_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
endif()

#EMSCRIPTEN_DEBUG_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_TOOLCHAIN_FILE=${EMSDK_TOOLCHAIN_FILE} ${DKCMAKE_FLAGS})
#EMSCRIPTEN_RELEASE_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_TOOLCHAIN_FILE=${EMSDK_TOOLCHAIN_FILE} ${DKCMAKE_FLAGS})
EMSCRIPTEN_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_TOOLCHAIN_FILE=${EMSDK_TOOLCHAIN_FILE} ${DKCMAKE_FLAGS})

#LINUX_DEBUG_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
#LINUX_RELEASE_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
LINUX_dk_set				(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})

MAC_HOST_dk_set				(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -T buildsystem=1 ${DKCMAKE_FLAGS})

#RASPBERRY_DEBUG_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
#RASPBERRY_RELEASE_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
RASPBERRY_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})

if(MSVC)
	WIN_X86_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A Win32 ${DKCMAKE_FLAGS})
	WIN_X86_64_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A x64 ${DKCMAKE_FLAGS})
else()
	#WIN_DEBUG_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	#WIN_RELEASE_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	WIN_dk_set				(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
endif()
dk_debug(DKCMAKE_BUILD	PRINTVAR)



###### Set DKCONFIGURE_BUILD variable ######
if(EMSCRIPTEN)
	dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
else()
	dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
endif()
