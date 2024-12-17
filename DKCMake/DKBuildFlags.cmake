#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
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



#set(DKCMAKE_COMMAND_LINE_TOOLCHAIN 0)
#set(DKCMAKE_LOAD_FILE_TOOLCHAIN 0)
#set(DKCMAKE_INTERNAL_TOOLCHAIN 1)
#dk_info("DKCMAKE_COMMAND_LINE_TOOLCHAIN = ${DKCMAKE_COMMAND_LINE_TOOLCHAIN}")
#dk_info("DKCMAKE_LOAD_FILE_TOOLCHAIN = ${DKCMAKE_LOAD_FILE_TOOLCHAIN}")
#dk_info("DKCMAKE_INTERNAL_TOOLCHAIN = ${DKCMAKE_INTERNAL_TOOLCHAIN}")
#if(NOT ${DKCMAKE_COMMAND_LINE_TOOLCHAIN})
#	dk_info("UNSET CMAKE_TOOLCHAIN_FILE")
#	dk_unset(CMAKE_TOOLCHAIN_FILE)
#endif()
#dk_info("CMAKE_TOOLCHAIN_FILE = ${CMAKE_TOOLCHAIN_FILE}")
#if(DKCMAKE_COMMAND_LINE_TOOLCHAIN)
#	dk_printVar("DKCMAKE_COMMAND_LINE_TOOLCHAIN")
#	dk_printVar(CMAKE_TOOLCHAIN_FILE)
#elseif(DKCMAKE_LOAD_FILE_TOOLCHAIN)
#	dk_printVar("DKCMAKE_LOAD_FILE_TOOLCHAIN")
#	#dk_load(${DKCMAKE_DIR}/toolchains/win_x86_64_clang_toolchain.cmake)
#elseif(DKCMAKE_INTERNAL_TOOLCHAIN)
#	dk_printVar("DKCMAKE_INTERNAL_TOOLCHAIN")
#else()
#	dk_fatal("NONE OF THE DKCMAKE TOOLCHAIN TYPES ARE SET")
#endif()


dk_validate(host_triple   "dk_host_triple()")
dk_validate(TARGET_TRIPLE "dk_target_triple()")
########### CORE DEPENDENCIES ############
dk_depend(cmake)

if(MINGW)
	dk_unset(CMAKE_IMPORT_LIBRARY_SUFFIX)
endif()
if(MSYS)
	dk_unset(CMAKE_IMPORT_LIBRARY_SUFFIX)
endif()
if(DEFINED ENV{WSLENV})
	dk_depend(wsl)
endif()
dk_depend(make)


### User Friendly Options ###
dk_set(BUILD_SHARED_LIBS				0)
dk_set(BUILD_STATIC_LIBS				1)
dk_set(BUILD_TESTING					0)
dk_set(ENABLE_EXCEPTIONS				1)    
dk_set(ENABLE_RTTI						1)
dk_set(POSITION_INDEPENDENT_CODE 		1)
dk_set(POSITION_INDEPENDENT_EXECUTABLE 	1)                                        
dk_set(WARNINGS_AS_ERRORS				0)
dk_set(WARNING_4244						0)	# /wd4244 - Warning: possible loss of data 
dk_set(WARNING_5105						0)	# /wd5105 - macro producing defined is undefined behaviour
dk_set(WARNING_LEVEL 					4)
dk_set(CMAKE_VERBOSE_MAKEFILE			1)

if(ANDROID)
	dk_set(POSITION_INDEPENDENT_EXECUTABLE 0) 
endif()

dk_append		(DKCMAKE_FLAGS -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS})
dk_append		(DKCMAKE_FLAGS -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS})
dk_append		(DKCMAKE_FLAGS -DBUILD_TESTING=${BUILD_TESTING})
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
	dk_append(CMAKE_C_FLAGS_DEBUG		/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
	dk_append(CMAKE_C_FLAGS_RELEASE		/MT /O2 /Ob2 /DNDEBUG)
	dk_append(CMAKE_CXX_FLAGS_DEBUG		/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
	dk_append(CMAKE_CXX_FLAGS_RELEASE	/MT /O2 /Ob2 /DNDEBUG)
else()
	
	dk_append(CMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
	dk_append(CMAKE_C_FLAGS_RELEASE		-O3 -DNDEBUG)
	dk_append(CMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
	dk_append(CMAKE_CXX_FLAGS_RELEASE	-O3 -DNDEBUG)
endif()
dk_append(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
dk_append(DKCONFIGURE_CFLAGS_RELEASE	-O3 -DNDEBUG)
dk_append(DKCONFIGURE_CXXFLAGS_DEBUG	-DDEBUG -D_DEBUG -g)
dk_append(DKCONFIGURE_CXXFLAGS_RELEASE	-O3 -DNDEBUG)


###### Flags FMT LIBRARY ######
if(MSVC)
	dk_append(CMAKE_C_FLAGS /utf-8)
	dk_append(CMAKE_CXX_FLAGS /utf-8)
endif()


###### POSITION_INDEPENDENT_CODE ######
# https://stackoverflow.com/a/3544211/688352   -fPIC vs -fpic
# https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-fPIC
if(WIN_HOST)
	dk_set(POSITION_INDEPENDENT_CODE 0)
endif()
if(POSITION_INDEPENDENT_CODE)
	if(WIN AND MSVC)
		
	else()
		dk_append(CMAKE_C_FLAGS -fPIC)
		dk_append(CMAKE_CXX_FLAGS -fPIC)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fPIC) 
	dk_append(DKCONFIGURE_CXXFLAGS -fPIC) 
else()	
	if(WIN AND MSVC)
		
	else()
#		dk_append(CMAKE_C_FLAGS -fno-pic)
#		dk_append(CMAKE_CXX_FLAGS -fno-pic)
	endif()
#	dk_append(DKCONFIGURE_CFLAGS -fno-pic) 
#	dk_append(DKCONFIGURE_CXXFLAGS -fno-pic) 
endif()
dk_printVar(POSITION_INDEPENDENT_CODE)

###### POSITION_INDEPENDENT_EXECUTABLE ######
# https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-fpie
if(POSITION_INDEPENDENT_EXECUTABLE)
	if(WIN AND MSVC)
	
	else()
#		dk_append(CMAKE_C_FLAGS -fPIE)
#		dk_append(CMAKE_CXX_FLAGS -fPIE)
	endif()
#	dk_append(DKCONFIGURE_CFLAGS -fPIE)
#	dk_append(DKCONFIGURE_CXXFLAGS -fPIE)
else()
	if(WIN AND MSVC)
	
	else()
		dk_append(CMAKE_C_FLAGS -fno-pie)
		dk_append(CMAKE_CXX_FLAGS -fno-pie)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fno-pie) 
	dk_append(DKCONFIGURE_CXXFLAGS -fno-pie) 
endif()
dk_printVar(POSITION_INDEPENDENT_EXECUTABLE)

###### RUN-TIME TYPE IDENTIFICATION ######
if(ENABLE_RTTI)
	if(WIN AND MSVC)
		dk_append(CMAKE_CXX_FLAGS /GR)
	else()
		dk_append(CMAKE_CXX_FLAGS -frtti)
	endif()
	dk_append(DKCONFIGURE_CXXFLAGS -frtti)
else()
	if(WIN AND MSVC)
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
dk_printVar(ENABLE_RTTI )

###### EXCEPTIONS ######
if(ENABLE_EXCEPTIONS)
	if(WIN AND MSVC)
		dk_append(CMAKE_C_FLAGS /EHsc)
		dk_append(CMAKE_CXX_FLAGS /EHsc)
	else()
		dk_append(CMAKE_C_FLAGS -fexceptions)
		dk_append(CMAKE_CXX_FLAGS -fexceptions)
	endif()
#	dk_append(DKCONFIGURE_CFLAGS -fexceptions) 
#	dk_append(DKCONFIGURE_CXXFLAGS -fexceptions)
else()
	if(WIN AND MSVC)
		dk_append(CMAKE_C_FLAGS /D_HAS_EXCEPTIONS=0)
		dk_append(CMAKE_CXX_FLAGS /D_HAS_EXCEPTIONS=0)
	else()
		dk_append(CMAKE_C_FLAGS -fno-exceptions)
		dk_append(CMAKE_CXX_FLAGS -fno-exceptions)
	endif()
	dk_append(DKCONFIGURE_CFLAGS -fno-exceptions) 
	dk_append(DKCONFIGURE_CXXFLAGS -fno-exceptions)
endif()
dk_printVar(ENABLE_EXCEPTIONS)





#################### TOOLCHAINS ##########################
### android_arm32
if(ANDROID_ARM32)
	dk_load(${DKCMAKE_DIR}/toolchains/android_arm32_toolchain.cmake)
endif()

### android_arm64
if(ANDROID_ARM64)
	dk_load(${DKCMAKE_DIR}/toolchains/android_arm32_toolchain.cmake)
endif()

### android_x86
if(ANDROID_X86)
	dk_load(${DKCMAKE_DIR}/toolchains/android_x86_toolchain.cmake)
endif()

### android_x86_64
if(ANDROID_X86_64)
	dk_load(${DKCMAKE_DIR}/toolchains/android_x86_64_toolchain.cmake)
endif()

### cosmopolitan ###
if(COSMOPOLITAN)
	dk_load(${DKCMAKE_DIR}/toolchains/cosmopolitan_toolchain.cmake)
endif()

### emscripten ###
if(EMSCRIPTEN)
	dk_load(${DKCMAKE_DIR}/toolchains/emscripten_toolchain.cmake)
endif()

### ios_arm32 - XCODE ###
if(IOS_ARM32)
	dk_load(${DKCMAKE_DIR}/toolchains/ios_arm32_toolchain.cmake)
endif()

### ios_arm64 - XCODE ###
if(IOS_ARM64)
	dk_load(${DKCMAKE_DIR}/toolchains/ios_arm64_toolchain.cmake)
endif()

### iOS Simulator x86 - XCODE ###
if(IOSSIM_X86)
	dk_load(${DKCMAKE_DIR}/toolchains/iossim_x86_toolchain.cmake)
endif()

### iOS Simulator x86_64 - XCODE ###
if(IOSSIM_X86_64)
	dk_load(${DKCMAKE_DIR}/toolchains/iossim_x86_64_toolchain.cmake)
endif()

### Linux x86 ###
if(LINUX_X86)
	dk_load(${DKCMAKE_DIR}/toolchains/linux_x86_toolchain.cmake)
endif()

#### Linux x86_64 - clang ###
if(LINUX_X86_64_CLANG)
	dk_load(${DKCMAKE_DIR}/toolchains/linux_x86_64_clang_toolchain.cmake)
endif()

#### Linux x86_64 - gcc ###
if(LINUX_X86_64_GCC)
	dk_load(${DKCMAKE_DIR}/toolchains/linux_x86_64_gcc_toolchain.cmake)
endif()

### Mac x86 - XCODE ###
if(MAC_X86)
	dk_load(${DKCMAKE_DIR}/toolchains/mac_x86_toolchain.cmake)
endif()

### Mac x86_64 - XCODE ###
if(MAC_X86_64)
	dk_load(${DKCMAKE_DIR}/toolchains/mac_x86_64_toolchain.cmake)
endif()

### Raspbery arm32 ###
if(RASPBERRY_ARM32)
	dk_load(${DKCMAKE_DIR}/toolchains/raspberry_arm32_toolchain.cmake)
endif()

### Raspbery arm64 ###
if(RASPBERRY_ARM64)
	dk_load(${DKCMAKE_DIR}/toolchains/raspberry_arm64_toolchain.cmake)
endif()

### Windows arm64 - CLANGARM64 ###
if(win_arm64_clang)
	dk_load(${DKCMAKE_DIR}/toolchains/win_arm64_clang_toolchain.cmake)
endif()

### Windows x86 - MSVC ###
if(win_x86_msvc)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_msvc_toolchain.cmake)
endif()

### Windows x86 - MINGW32 ###
if(win_x86_mingw)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_mingw_toolchain.cmake)
endif()

### Windows x86 - CLANG32 ###
if(win_x86_clang)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_clang_toolchain.cmake)
endif()

### Windows x86_64 - MSVC ###
if(win_x86_64_msvc)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_64_msvc_toolchain.cmake)
endif()

### Windows x86_64 - CLANG64 ###
if(win_x86_64_clang)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_64_clang_toolchain.cmake)
endif()

### Windows x86_64 - MINGW64 ###
if(win_x86_64_mingw)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_64_mingw_toolchain.cmake)
endif()

### Windows x86_64 - UCRT64 ###
if(win_x86_64_ucrt)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_64_ucrt_toolchain.cmake)
endif()

### Windows x86_64 - MSYS ###
if(win_x86_64_msys)
	dk_load(${DKCMAKE_DIR}/toolchains/win_x86_64_msys_toolchain.cmake)
endif()


#dk_printVar(MSYSTEM)
dk_assertVar(CMAKE_GENERATOR)
#dk_printVar(CMAKE_MAKE_PROGRAM)
#dk_printVar(CMAKE_C_FLAGS)
#dk_printVar(CMAKE_CXX_FLAGS)
#dk_printVar(CMAKE_EXE_LINKER_FLAGS)


######### Extra Flags and Settings #########
if(WARNINGS_AS_ERRORS)
	if(MSVC)
		dk_append	(CMAKE_C_FLAGS		/WX)
		dk_append	(CMAKE_CXX_FLAGS	/WX)
	else()
		dk_append	(CMAKE_C_FLAGS		-Werror)
		dk_append	(CMAKE_CXX_FLAGS	-Werror)
	endif()
endif()
if(WARNING_LEVEL)
	if(MSVC)
		dk_append	(CMAKE_C_FLAGS		/W${WARNING_LEVEL})
		dk_append	(CMAKE_CXX_FLAGS	/W${WARNING_LEVEL})
	endif()
endif()
if(WARNING_4244) # /wd4244 - Warning: possible loss of data 
	if(MSVC)
		dk_append	(CMAKE_C_FLAGS		/wd4244)
		dk_append	(CMAKE_CXX_FLAGS	/wd4244)
	endif()
endif()
if(WARNING_5105) # /wd5105 - macro producing defined is undefined behaviour
	if(MSVC)
		dk_append	(CMAKE_C_FLAGS		/wd5105)
		dk_append	(CMAKE_CXX_FLAGS	/wd5105)
	endif()
endif()




# GENERATOR			CONFIG_PATH		  		  	BUILD_PATH
# -----------------------------------------------------------------------
# Visual Studio  	${triple}					${triple}/${DKBUILD_TYPE}		
# XCODE			    ${triple}					${triple}/${DKBUILD_TYPE} 
# MinGW Makefiles   ${triple}/${DKBUILD_TYPE}	${triple}/${DKBUILD_TYPE} 
# Unix Makefiles    ${triple}/${DKBUILD_TYPE}   ${triple}/${DKBUILD_TYPE}  
# ./configure       ${triple}/${DKBUILD_TYPE}   ${triple}/${DKBUILD_TYPE}

# https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#build-configurations
# https://cmake.org/cmake/help/latest/variable/CMAKE_CONFIGURATION_TYPES.html
# https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html



############## Setup continued by cmake from here ##############
if(CMAKE_GENERATOR_PLATFORM)
	dk_append				(DKCMAKE_FLAGS 		-A ${CMAKE_GENERATOR_PLATFORM})
endif()
if(CMAKE_BUILD_TYPE)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
endif()
if(CMAKE_TOOLCHAIN_FILE)
	# FIXME: make sure the path uses foward slashes
	dk_replaceAll(${CMAKE_TOOLCHAIN_FILE}  "\\"  "/"  CMAKE_TOOLCHAIN_FILE)
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
if(CMAKE_C_FLAGS)
	dk_replaceAll("${CMAKE_C_FLAGS}"  ";"  " "  CMAKE_C_FLAGS)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS})
endif()
if(CMAKE_C_FLAGS_DEBUG)
	dk_replaceAll("${CMAKE_C_FLAGS_DEBUG}"  ";"  " "  CMAKE_C_FLAGS_DEBUG)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG})
endif()
if(CMAKE_C_FLAGS_RELEASE)
	dk_replaceAll("${CMAKE_C_FLAGS_RELEASE}"  ";"  " "  CMAKE_C_FLAGS_RELEASE)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE})
endif()
if(CMAKE_CXX_COMPILER)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
endif()
if(CMAKE_CXX_FLAGS)
	dk_replaceAll("${CMAKE_CXX_FLAGS}"  ";"  " "  CMAKE_CXX_FLAGS)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS})
endif()
if(CMAKE_CXX_FLAGS_DEBUG)
	dk_replaceAll("${CMAKE_CXX_FLAGS_DEBUG}"  ";"  " "  CMAKE_CXX_FLAGS_DEBUG)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_FLAGS_DEBUG=${CMAKE_CXX_FLAGS_DEBUG})
endif()
if(CMAKE_CXX_FLAGS_RELEASE)
	dk_replaceAll("${CMAKE_CXX_FLAGS_RELEASE}"  ";"  " "  CMAKE_CXX_FLAGS_RELEASE)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_CXX_FLAGS_RELEASE=${CMAKE_CXX_FLAGS_RELEASE})
endif()
if(CMAKE_EXE_LINKER_FLAGS)
	dk_replaceAll("${CMAKE_EXE_LINKER_FLAGS}"  ";"  " "  CMAKE_EXE_LINKER_FLAGS)
	dk_append				(DKCMAKE_FLAGS 		-DCMAKE_EXE_LINKER_FLAGS=${CMAKE_EXE_LINKER_FLAGS})
endif()


############ DKCONFIGURE variables ############
if((NOT DKCONFIGURE_CC) AND (CMAKE_C_COMPILER))
	dk_set(DKCONFIGURE_CC			"${CMAKE_C_COMPILER}")
endif()
if((NOT DKCONFIGURE_CXX) AND (CMAKE_CXX_COMPILER))
	dk_set(DKCONFIGURE_CXX			"${CMAKE_CXX_COMPILER}")
endif()
if((NOT DKCONFIGURE_CFLAGS) AND (CMAKE_C_FLAGS))
	dk_append(DKCONFIGURE_CFLAGS	${CMAKE_C_FLAGS})
endif()
if((NOT DKCONFIGURE_CXXFLAGS) AND (CMAKE_CXX_FLAGS))
	dk_append(DKCONFIGURE_CXXFLAGS	${CMAKE_CXX_FLAGS})
endif()

if(DKCONFIGURE_CC)
	dk_append		(DKCONFIGURE_FLAGS CC=${DKCONFIGURE_CC})
endif()
if(DKCONFIGURE_CXX)
	dk_append		(DKCONFIGURE_FLAGS CXX=${DKCONFIGURE_CXX})
endif()
if(DKCONFIGURE_CFLAGS)
	dk_replaceAll("${DKCONFIGURE_CFLAGS}"  ";"  " "  DKCONFIGURE_CFLAGS)
	dk_append		(DKCONFIGURE_FLAGS CFLAGS=${DKCONFIGURE_CFLAGS})
endif()
if(DKCONFIGURE_CXXFLAGS)
	dk_replaceAll("${DKCONFIGURE_CXXFLAGS}"  ";"  " "  DKCONFIGURE_CXXFLAGS)
	dk_append		(DKCONFIGURE_FLAGS CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
endif()
dk_printVar(DKCONFIGURE_FLAGS)






###### Set DKCMAKE_BUILD and DKCONFIGURE_BUILD variables ######
if(EMSCRIPTEN)
	dk_set(DKCMAKE_BUILD ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
else()
	dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
endif()

dk_printVar(DKCMAKE_BUILD)
#dk_printVar(CMAKE_C_FLAGS)
#dk_printVar(CMAKE_CXX_FLAGS)