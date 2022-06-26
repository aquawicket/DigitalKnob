# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright noticeand this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()

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
# i686 
# x86_64
# arm
# arm_64

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
# gcc -c -Q -march=native --help=target		target specific compiler gcc flags        https://explainshell.com/explain?cmd=gcc+-c+-Q+-march%3Dnative+--help%3Dtarget
# gcc --version                             the version of gcc on the host machine    https://explainshell.com/explain?cmd=gcc+--version
# gcc --help                                general gcc help                          https://explainshell.com/explain?cmd=gcc+--help
# clang --version                           the version of clang on the host machine  https://explainshell.com/explain?cmd=clang+--version 
# clang--help                               general clang help                        https://explainshell.com/explain?cmd=clang+--help
# gcc-fpu                                   ARM processor floating point math         https://explainshell.com/explain?cmd=gcc+-fpu

# common flags for compilers
#										GCC					CLANG/LLVM			MSVC													NOTES
# Enable runtime type information		-frtti				-frtti				/GR                                                        
# Disable runtime type information		-frtti				-frtti				/GR-                                                         
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


### User Friendly Options ###
dk_set(WARNINGS_AS_ERRORS	OFF)
dk_set(WARNING_LEVEL 		3)
dk_set(WARNING_4244			ON)
dk_set(WARNING_5105			ON)
dk_set(STATIC				ON)
#dk_set(SHARED				OFF)                                          

# xcode Variables
dk_set(XCODE_DEVROOT	/Applications/Xcode.app/Contents/Developer)
dk_set(XCODE_CLANG		${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang)
dk_set(XCODE_CLANGXX	${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++)
dk_set(XCODE_LIBTOOL	${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool)

# iOS variables
dk_set(IOS_DARWIN		darwin20.6.0)
dk_set(IOS_MIN_SDK		13.0)
dk_set(IOS_SYSROOT		${XCODE_DEVROOT}/Platforms/iPhone.platform/Developer/SDKs/iPhone15.0.sdk)
dk_set(IOSSIM_SYSROOT	${XCODE_DEVROOT}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.0.sdk)

# linux variables
dk_set(LINUX_GCC		/usr/bin/gcc)
dk_set(LINUX_GXX		/usr/bin/g++)

# Visual C++ variables 
dk_set(MSVC_CL			"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx64/x86/cl.exe")
dk_set(MINGW32			"${3RDPARTY}/mingw32-i686-8.1.0-release-posix-dwarf-rt_v6-rev0")
dk_set(MINGW64			"${3RDPARTY}/mingw64-x86_64-8.1.0-release-posix-seh-rt_v6-rev0")
dk_set(MINGW32_GCC  	"${MINGW32}/bin/gcc.exe")
dk_set(MINGW32_GXX  	"${MINGW32}/bin/g++.exe")
dk_set(MINGW64_GCC  	"${MINGW64}/bin/gcc.exe")
dk_set(MINGW64_GXX  	"${MINGW64}/bin/g++.exe")
 

# Windows i686 (32)
WIN32_dk_set(DKCMAKE_FLAGS					-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
WIN32_dk_set(DKCMAKE_C_COMPILER				${MSVC_CL})
WIN32_dk_set(DKCMAKE_C_FLAGS				/DWIN /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /GR /EHsc /Zm500 /Zc:__cplusplus) #/DWIN32 /D_WINDOWS /D_WIN32_WINNT=0x0600
WIN32_dk_set(DKCMAKE_C_FLAGS_DEBUG			/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
WIN32_dk_set(DKCMAKE_C_FLAGS_RELEASE		/MT /O2 /Ob2 /DNDEBUG /DRELEASE)
WIN32_dk_set(DKCMAKE_CXX_COMPILER			${MSVC_CL})
WIN32_dk_set(DKCMAKE_CXX_FLAGS				/DWIN /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /GR /EHsc /Zm500 /Zc:__cplusplus) #/DWIN32 /D_WINDOWS /D_WIN32_WINNT=0x0600
WIN32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
WIN32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		/MT /O2 /Ob2 /DNDEBUG /DRELEASE)
WIN32_dk_set(DKCONFIGURE_FLAGS				--build=i686-w64-mingw32 --disable-shared --enable-static)
WIN32_dk_set(DKCONFIGURE_CC					${MINGW32_GCC})
WIN32_dk_set(DKCONFIGURE_CFLAGS				-march=i686 -DWIN -DWIN32 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17 -fexceptions) #-D_WIN32_WINNT=0x0600 
WIN32_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
WIN32_dk_set(DKCONFIGURE_CFLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
WIN32_dk_set(DKCONFIGURE_CXX				${MINGW32_GXX})
WIN32_dk_set(DKCONFIGURE_CXXFLAGS			-march=i686 -DWIN -DWIN32 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17 -frtti -fexceptions) #-D_WIN32_WINNT=0x0600
WIN32_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
WIN32_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
		
# Windows x86_64 (64)
WIN64_dk_set(DKCMAKE_FLAGS					-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
WIN64_dk_set(DKCMAKE_C_COMPILER				${MSVC_CL})
WIN64_dk_set(DKCMAKE_C_FLAGS				/DWIN /DWIN64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /GR /EHsc /Zm500 /Zc:__cplusplus /MACHINE:X64) #/D_WIN32_WINNT=0x0600
WIN64_dk_set(DKCMAKE_C_FLAGS_DEBUG			/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
WIN64_dk_set(DKCMAKE_C_FLAGS_RELEASE		/MT /O2 /Ob2 /DNDEBUG /DRELEASE)
WIN64_dk_set(DKCMAKE_CXX_COMPILER			${MSVC_CL})
WIN64_dk_set(DKCMAKE_CXX_FLAGS				/DWIN /DWIN64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /GR /EHsc /Zm500 /Zc:__cplusplus /MACHINE:X64) #/D_WIN32_WINNT=0x0600
WIN64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG)
WIN64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		/MT /O2 /Ob2 /DNDEBUG /DRELEASE)
WIN64_dk_set(DKCONFIGURE_FLAGS				--build=x86_64-w64-mingw32 --disable-shared --enable-static)
WIN64_dk_set(DKCONFIGURE_CC					${MINGW64_GCC})
WIN64_dk_set(DKCONFIGURE_CFLAGS				-march=x86-64 -DWIN -DWIN64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_WIN32_WINNT=0x0600 -D_USING_V110_SDK71_ -std=gnu17 -fexceptions) #/D_WIN32_WINNT=0x0600
WIN64_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
WIN64_dk_set(DKCONFIGURE_CFLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
WIN64_dk_set(DKCONFIGURE_CXX				${MINGW64_GXX})
WIN64_dk_set(DKCONFIGURE_CXXFLAGS			-march=x86-64 -DWIN -DWIN64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_WIN32_WINNT=0x0600 -D_USING_V110_SDK71_ -std=gnu++17 -frtti -fexceptions) #/D_WIN32_WINNT=0x0600
WIN64_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
WIN64_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# Moc i686 (32)
MAC32_dk_set(DKCMAKE_FLAGS					-DCMAKE_OSX_ARCHITECTURES=x86 -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
MAC32_dk_set(DKCMAKE_C_COMPILER				${XCODE_CLANG})
MAC32_dk_set(DKCMAKE_C_FLAGS				-DMAC -DMAC32 -std=c17 -x objective-c)
MAC32_dk_set(DKCMAKE_C_FLAGS_DEBUG			-DDEBUG -D_DEBUG -g)
MAC32_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
MAC32_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CLANGXX})
MAC32_dk_set(DKCMAKE_CXX_FLAGS				-DMAC -DMAC32 -std=c++17 -x objective-c++)
MAC32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
MAC32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
MAC32_dk_set(DKCONFIGURE_FLAGS				--disable-shared --enable-static)
#MAC32_dk_set(DKCONFIGURE_CC				${XCODE_CLANG})
MAC32_dk_set(DKCONFIGURE_CFLAGS				-arch i686 -DMAC -DMAC32 -std=c17) #-x objective-c) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
MAC32_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
MAC32_dk_set(DKCONFIGURE_CFLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
#MAC32_dk_set(DKCONFIGURE_CXX				${XCODE_CLANGXX})
MAC32_dk_set(DKCONFIGURE_CXXFLAGS			-arch i686 -DMAC -DMAC32 -std=c++17 -x objective-c++) #-x objective-c++) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
MAC32_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
MAC32_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# Moc x86_64 (64)
MAC64_dk_set(DKCMAKE_FLAGS					-DCMAKE_OSX_ARCHITECTURES=x86_64 -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
MAC64_dk_set(DKCMAKE_C_COMPILER				${XCODE_CLANG})
MAC64_dk_set(DKCMAKE_C_FLAGS				-DMAC -DMAC64 -std=c17 -x objective-c)
MAC64_dk_set(DKCMAKE_C_FLAGS_DEBUG			-DDEBUG -D_DEBUG -g)
MAC64_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
MAC64_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CLANGXX})
MAC64_dk_set(DKCMAKE_CXX_FLAGS				-DMAC -DMAC64 -std=c++17 -x objective-c++)
MAC64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
MAC64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
MAC64_dk_set(DKCONFIGURE_FLAGS				--disable-shared --enable-static)
#MAC64_dk_set(DKCONFIGURE_CC				${XCODE_CLANG})
MAC64_dk_set(DKCONFIGURE_CFLAGS				-DMAC -DMAC64 -std=c17) #-x objective-c) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
MAC64_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
MAC64_dk_set(DKCONFIGURE_CFLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
#MAC64_dk_set(DKCONFIGURE_CXX				${XCODE_CLANGXX})
MAC64_dk_set(DKCONFIGURE_CXXFLAGS			-DMAC -DMAC64 -std=c++17) #-x objective-c++) #https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
MAC64_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
MAC64_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# iOS i686 (32)
IOS32_dk_set(DKCMAKE_FLAGS					-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DPLATFORM=OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
#IOS32_dk_set(DKCMAKE_C_COMPILER			${XCODE_CLANG})
IOS32_dk_set(DKCMAKE_C_FLAGS				-DIOS -DIOS32 -std=c17 -x objective-c)
IOS32_dk_set(DKCMAKE_C_FLAGS_DEBUG			-DDEBUG -D_DEBUG -g)
IOS32_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
#IOS32_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CLANGXX})
IOS32_dk_set(DKCMAKE_CXX_FLAGS				-DIOS -DIOS32 -std=c++17 -x objective-c++)
IOS32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOS32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
IOS32_dk_set(DKCONFIGURE_FLAGS				--disable-shared --enable-static --host i686-apple-${IOS_DARWIN})
IOS32_dk_set(DKCONFIGURE_CC					${XCODE_CLANG})
IOS32_dk_set(DKCONFIGURE_CFLAGS				-arch i686 -DIOS -DIOS32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
IOS32_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOS32_dk_set(DKCONFIGURE_CFLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
IOS32_dk_set(DKCONFIGURE_CXX				${XCODE_CLANGXX})
IOS32_dk_set(DKCONFIGURE_CXXFLAGS			-arch i686 -DIOS -DIOS32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
IOS32_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOS32_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# iOS x86_64 (64)
IOS64_dk_set(DKCMAKE_FLAGS					-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=${IOS_MIN_SDK})
#IOS64_dk_set(DKCMAKE_C_COMPILER			${XCODE_CLANG})
IOS64_dk_set(DKCMAKE_C_FLAGS				-DIOS -DIOS64 -std=c17 -x objective-c)
IOS64_dk_set(DKCMAKE_C_FLAGS_DEBUG			-DDEBUG -D_DEBUG -g)
IOS64_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
#IOS64_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CLANGXX})
IOS64_dk_set(DKCMAKE_CXX_FLAGS				-DIOS -DIOS64 -std=c++17 -x objective-c++)
IOS64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOS64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
IOS64_dk_set(DKCONFIGURE_FLAGS				--disable-shared --enable-static --host x86_64-apple-${IOS_DARWIN})
IOS64_dk_set(DKCONFIGURE_CC					${XCODE_CLANG})
IOS64_dk_set(DKCONFIGURE_CFLAGS				-arch x86_64 -DIOS -DIOS64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
IOS64_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOS64_dk_set(DKCONFIGURE_CFLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
IOS64_dk_set(DKCONFIGURE_CXX				${XCODE_CLANGXX})
IOS64_dk_set(DKCONFIGURE_CXXFLAGS			-arch x86_64 -DIOS -DIOS64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
IOS64_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOS64_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# iOS Simulator i686 (32)
IOSSIM32_dk_set(DKCMAKE_FLAGS				-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0)
#IOSSIM32_dk_set(DKCMAKE_C_COMPILER			${XCODE_CLANG})
IOSSIM32_dk_set(DKCMAKE_C_FLAGS				-DIOS -DIOS32 -DIOSSIM -DIOSSIM32 -std=c17 -x objective-c)
IOSSIM32_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOSSIM32_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
#IOSSIM32_dk_set(DKCMAKE_CXX_COMPILER		${XCODE_CLANGXX})
IOSSIM32_dk_set(DKCMAKE_CXX_FLAGS			-DIOS -DIOS32 -DIOSSIM -DIOSSIM32 -std=c++17 -x objective-c++)
IOSSIM32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOSSIM32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
IOSSIM32_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static --host i686-apple-${IOS_DARWIN})
IOSSIM32_dk_set(DKCONFIGURE_CC				${XCODE_CLANG})
IOSSIM32_dk_set(DKCONFIGURE_CFLAGS			-arch i686 -DIOS -DIOS32 -DIOSSIM -DIOSSIM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
IOSSIM32_dk_set(DKCONFIGURE_CXX				${XCODE_CLANGXX})
IOSSIM32_dk_set(DKCONFIGURE_CXXFLAGS		-arch i686 -DIOS -DIOS32 -DIOSSIM -DIOSSIM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})

# iOS Simulator x86_64 (64)
IOSSIM64_dk_set(DKCMAKE_FLAGS				-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0)
#IOSSIM64_dk_set(DKCMAKE_C_COMPILER			)
IOSSIM64_dk_set(DKCMAKE_C_FLAGS				-DIOS -DIOS64 -DIOSSIM -DIOSSIM64 -std=c17 -x objective-c)
IOSSIM64_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOSSIM64_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
#IOSSIM64_dk_set(DKCMAKE_CXX_COMPILER		)
IOSSIM64_dk_set(DKCMAKE_CXX_FLAGS			-DIOS -DIOS64 -DIOSSIM -DIOSSIM64 -std=c++17 -x objective-c++)
IOSSIM64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
IOSSIM64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
IOSSIM64_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static --host x86_64-apple-${IOS_DARWIN})
IOSSIM64_dk_set(DKCONFIGURE_CC				${XCODE_CLANG})
IOSSIM64_dk_set(DKCONFIGURE_CFLAGS			-arch x86_64 -DIOS -DIOS64 -DIOSSIM -DIOSSIM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
IOSSIM64_dk_set(DKCONFIGURE_CXX				${XCODE_CLANGXX})
IOSSIM64_dk_set(DKCONFIGURE_CXXFLAGS		-arch x86_64 -DIOS -DIOS64 -DIOSSIM -DIOSSIM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})

# Linux i686 (32)
LINUX32_dk_set(DKCMAKE_FLAGS				-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
LINUX32_dk_set(DKCMAKE_C_COMPILER			${LINUX_GCC})
LINUX32_dk_set(DKCMAKE_C_FLAGS				-march=i686 -DLINUX -DLINUX32 -std=gnu11 -no-pie -fPIC)
LINUX32_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
LINUX32_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
LINUX32_dk_set(DKCMAKE_CXX_COMPILER			${LINUX_GXX})
LINUX32_dk_set(DKCMAKE_CXX_FLAGS			-march=i686 -DLINUX -DLINUX32 -std=gnu++17 -lstdc++fs -no-pie -fPIC)
LINUX32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
LINUX32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
LINUX32_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static)
LINUX32_dk_set(DKCONFIGURE_CC				${LINUX_GCC})
LINUX32_dk_set(DKCONFIGURE_CFLAGS			-march=i686 -DLINUX -DLINUX32 -std=gnu11 -no-pie -fPIC)
LINUX32_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
LINUX32_dk_set(DKCONFIGURE_CFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
LINUX32_dk_set(DKCONFIGURE_CXX				${LINUX_GXX})
LINUX32_dk_set(DKCONFIGURE_CXXFLAGS			-march=i686 -DLINUX -DLINUX32 -std=gnu++17 -lstdc++fs -no-pie -fPIC)
LINUX32_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG	-DDEBUG -D_DEBUG -g)
LINUX32_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# Linux x86_64 (64)
LINUX64_dk_set(DKCMAKE_FLAGS				-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
LINUX64_dk_set(DKCMAKE_C_COMPILER			${LINUX_GCC})
LINUX64_dk_set(DKCMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX64 -std=gnu11 -no-pie -fPIC)
LINUX64_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
LINUX64_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
LINUX64_dk_set(DKCMAKE_CXX_COMPILER			${LINUX_GXX})
LINUX64_dk_set(DKCMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX64 -std=gnu++17 -lstdc++fs -no-pie -fPIC)
LINUX64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
LINUX64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
LINUX64_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static)
LINUX64_dk_set(DKCONFIGURE_CC				${LINUX_GCC})
LINUX64_dk_set(DKCONFIGURE_CFLAGS			-march=x86-64 -DLINUX -DLINUX64 -std=gnu11 -no-pie -fPIC)
LINUX64_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
LINUX64_dk_set(DKCONFIGURE_CFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
LINUX64_dk_set(DKCONFIGURE_CXX				${LINUX_GXX})
LINUX64_dk_set(DKCONFIGURE_CXXFLAGS			-march=x86-64 -DLINUX -DLINUX64 -std=gnu++17 -lstdc++fs -no-pie -fPIC)
LINUX64_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG	-DDEBUG -D_DEBUG -g)
LINUX64_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# Raspbery arm (32)
RASPBERRY32_dk_set(DKCMAKE_FLAGS				-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
RASPBERRY32_dk_set(DKCMAKE_C_COMPILER			${LINUX_GCC})
RASPBERRY32_dk_set(DKCMAKE_C_FLAGS				-DLINUX -DLINUX32 -DRASPBERRY -DRASPBERRY32 -std=gnu11 -no-pie -fPIC) #-march=armv7l
RASPBERRY32_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
RASPBERRY32_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
RASPBERRY32_dk_set(DKCMAKE_CXX_COMPILER			${LINUX_GXX})
RASPBERRY32_dk_set(DKCMAKE_CXX_FLAGS			-DLINUX -DLINUX32 -DRASPBERRY -DRASPBERRY32 -std=gnu++17 -lstdc++fs -no-pie -fPIC) #-march=armv7l 
RASPBERRY32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
RASPBERRY32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
RASPBERRY32_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static)
RASPBERRY32_dk_set(DKCONFIGURE_CC				${LINUX_GCC})
RASPBERRY32_dk_set(DKCONFIGURE_CFLAGS			-DLINUX -DLINUX32 -DRASPBERRY -DRASPBERRY32 -std=gnu11 -no-pie -fPIC) #-march=armv7l 
RASPBERRY32_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
RASPBERRY32_dk_set(DKCONFIGURE_CFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
RASPBERRY32_dk_set(DKCONFIGURE_CXX				${LINUX_GXX})
RASPBERRY32_dk_set(DKCONFIGURE_CXXFLAGS			-DLINUX -DLINUX32 -DRASPBERRY -DRASPBERRY32 -std=gnu++17 -lstdc++fs -no-pie -fPIC) #-march=armv7l 
RASPBERRY32_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG	-DDEBUG -D_DEBUG -g)
RASPBERRY32_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# Raspbery arm64 (64)
RASPBERRY64_dk_set(DKCMAKE_FLAGS				-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON)
RASPBERRY64_dk_set(DKCMAKE_C_COMPILER			${LINUX_GCC})
RASPBERRY64_dk_set(DKCMAKE_C_FLAGS				-march=armv7l -DLINUX -DLINUX64 -DRASPBERRY -DRASPBERRY64 -std=gnu11 -no-pie -fPIC)
RASPBERRY64_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
RASPBERRY64_dk_set(DKCMAKE_C_FLAGS_RELEASE		-DNDEBUG -DRELEASE -O3)
RASPBERRY64_dk_set(DKCMAKE_CXX_COMPILER			${LINUX_GXX})
RASPBERRY64_dk_set(DKCMAKE_CXX_FLAGS			-march=armv7l -DLINUX -DLINUX64 -DRASPBERRY -DRASPBERRY64 -std=gnu++17 -lstdc++fs -no-pie -fPIC)
RASPBERRY64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
RASPBERRY64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
RASPBERRY64_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static)
RASPBERRY64_dk_set(DKCONFIGURE_CC				${LINUX_GCC})
RASPBERRY64_dk_set(DKCONFIGURE_CFLAGS			-march=armv7l -DLINUX -DLINUX64 -DRASPBERRY -DRASPBERRY64 -std=gnu11 -no-pie -fPIC)
RASPBERRY64_dk_set(DKCONFIGURE_CFLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
RASPBERRY64_dk_set(DKCONFIGURE_CFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
RASPBERRY64_dk_set(DKCONFIGURE_CXX				${LINUX_GXX})
RASPBERRY64_dk_set(DKCONFIGURE_CXXFLAGS			-march=armv7l -DLINUX -DLINUX64 -DRASPBERRY -DRASPBERRY64 -std=gnu++17 -lstdc++fs -no-pie -fPIC)
RASPBERRY64_dk_set(DKCONFIGURE_CXXFLAGS_DEBUG	-DDEBUG -D_DEBUG -g)
RASPBERRY64_dk_set(DKCONFIGURE_CXXFLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)

# ANDROID_dk_depend(android-ndk) #for ${ANDROID-NDK}
# Android armeabi-v7a (32)
ANDROID32_dk_set(DKCMAKE_FLAGS
	-DBUILD_SHARED_LIBS=OFF 
	-DBUILD_STATIC_LIBS=ON
	-DANDROID_PLATFORM=26
	-DANDROID_NDK=${ANDROID-NDK}
	-DCMAKE_TOOLCHAIN_FILE=${ANDROID-NDK}/build/cmake/android.toolchain.cmake
	-DANDROID_TOOLCHAIN=clang
	-DANDROID_ABI=armeabi-v7a
	-DANDROID_STL=c++_static
	-DANDROID_STL_FORCE_FEATURES=1
	-DANDROID_CPP_FEATURES=rtti
	-DCMAKE_ANDROID_STL_TYPE=c++_static) # exceptions)
#ANDROID32_dk_set(DKCMAKE_C_COMPILER		)
ANDROID32_dk_set(DKCMAKE_C_FLAGS			-DANDROID -DANDROID32 -frtti -std=c17) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
ANDROID32_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -frtti -g)
ANDROID32_dk_set(DKCMAKE_C_FLAGS_RELEASE	-DNDEBUG -DRELEASE -frtti -O3)
#ANDROID32_dk_set(DKCMAKE_CXX_COMPILER		)
ANDROID32_dk_set(DKCMAKE_CXX_FLAGS			-DANDROID -DANDROID32 -frtti -std=c++1z) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
ANDROID32_dk_set(DKCMAKE_CXX_FLAGS_DEBUG	-DDEBUG -D_DEBUG -frtti -g)
ANDROID32_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -frtti -O3)
ANDROID32_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static)
#ANDROID32_dk_set(DKCONFIGURE_CC			${CLANG})
ANDROID32_dk_set(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID32 -frtti -std=c17) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID32_dk_set(DKCONFIGURE_CXX			${CLANGXX})
ANDROID32_dk_set(DKCONFIGURE_CXXFLAGS		-DANDROID -DANDROID32 -frtti -std=c++1z) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined

# Android arm64-v8a (64)
ANDROID64_dk_set(DKCMAKE_FLAGS
	-DBUILD_SHARED_LIBS=OFF 
	-DBUILD_STATIC_LIBS=ON
	-DANDROID_PLATFORM=26
	-DANDROID_NDK=${ANDROID-NDK}
	-DCMAKE_TOOLCHAIN_FILE=${ANDROID-NDK}/build/cmake/android.toolchain.cmake
	-DANDROID_TOOLCHAIN=clang
	-DANDROID_ABI=arm64-v8a
	-DANDROID_STL=c++_static
	-DANDROID_CPP_FEATURES=rtti) #exceptions)
#ANDROID64_dk_set(DKCMAKE_C_COMPILER		)
ANDROID64_dk_set(DKCMAKE_C_FLAGS			-DANDROID -DANDROID64 -std=c17) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
ANDROID64_dk_set(DKCMAKE_C_FLAGS_DEBUG		-DDEBUG -D_DEBUG -g)
ANDROID64_dk_set(DKCMAKE_C_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
#ANDROID64_dk_set(DKCMAKE_CXX_COMPILER		)
ANDROID64_dk_set(DKCMAKE_CXX_FLAGS			-DANDROID -DANDROID64 -std=c++1z) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
ANDROID64_dk_set(DKCMAKE_CXX_FLAGS_DEBUG	-DDEBUG -D_DEBUG -g)
ANDROID64_dk_set(DKCMAKE_CXX_FLAGS_RELEASE	-DNDEBUG -DRELEASE -O3)
ANDROID64_dk_set(DKCONFIGURE_FLAGS			--disable-shared --enable-static)
#ANDROID64_dk_set(DKCONFIGURE_CC			${CLANG})
ANDROID64_dk_set(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID64 -std=c17) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID64_dk_set(DKCONFIGURE_CXX			${CLANGXX})
ANDROID64_dk_set(DKCONFIGURE_CXXFLAGS		-DANDROID -DANDROID64 -std=c++1z) #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined





######### Extra Flags and Settings #########
if(WARNINGS_AS_ERRORS)
	if(WIN)
		##WIN_dk_set	(DKCMAKE_C_FLAGS	${DKCMAKE_C_FLAGS}	 /WX)
		##WIN_dk_set	(DKCMAKE_CXX_FLAGS	${DKCMAKE_CXX_FLAGS} /WX)
		list(APPEND DKCMAKE_C_FLAGS 	/WX)
		list(APPEND DKCMAKE_CXX_FLAGS 	/WX)
	endif()
	if(UNIX)
		#UNIX_dk_set	(DCMAKE_C_FLAGS		${DKCMAKE_C_FLAGS} 		-Werror)
		#UNIX_dk_set	(DCMAKE_CXX_FLAGS	${DKCMAKE_CXX_FLAGS} 	-Werror)
		list(APPEND DKCMAKE_C_FLAGS 	-Werror)
		list(APPEND DKCMAKE_CXX_FLAGS 	-Werror)
	endif()
endif()
if(WARNING_LEVEL)
	if(WIN)
		#WIN_dk_set	(DKCMAKE_C_FLAGS	${DKCMAKE_C_FLAGS}	 /W${WARNING_LEVEL})
		#WIN_dk_set	(DKCMAKE_CXX_FLAGS	${DKCMAKE_CXX_FLAGS} /W${WARNING_LEVEL})
		list(APPEND DKCMAKE_C_FLAGS 	/W${WARNING_LEVEL})
		list(APPEND DKCMAKE_CXX_FLAGS 	/W${WARNING_LEVEL})
	endif()
endif()
if(WARNING_4244) # /wd4244 - Warning: possible loss of data 
	if(WIN)
		#WIN_dk_set	(DKCMAKE_C_FLAGS	${DKCMAKE_C_FLAGS} 			/wd4244)
		#WIN_dk_set	(DKCMAKE_CXX_FLAGS	${DKCMAKE_CXX_FLAGS}		 /wd4244)
		list(APPEND DKCMAKE_C_FLAGS 	/wd4244)
		list(APPEND DKCMAKE_CXX_FLAGS 	/wd4244)
	endif()
endif()
if(WARNING_5105) # /wd5105 - macro producing defined is undefined behaviour
	if(WIN)
		#WIN_dk_set	(DKCMAKE_C_FLAGS	${DKCMAKE_C_FLAGS} 		/wd5105)
		#WIN_dk_set	(DKCMAKE_CXX_FLAGS	${DKCMAKE_CXX_FLAGS}	/wd5105)
		list(APPEND DKCMAKE_C_FLAGS 	/wd5105)
		list(APPEND DKCMAKE_CXX_FLAGS 	/wd5105)
	endif()
endif()




############## Setup continued by cmake from here ##############
string(REPLACE " " ";" CMAKE_C_FLAGS ${CMAKE_C_FLAGS})
string(REPLACE " " ";" CMAKE_C_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
string(REPLACE " " ";" CMAKE_C_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE})
string(REPLACE " " ";" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
string(REPLACE " " ";" CMAKE_CXX_FLAGS_DEBUG ${CMAKE_CXX_FLAGS_DEBUG})
string(REPLACE " " ";" CMAKE_CXX_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})


#dk_set						(CMAKE_C_FLAGS				${CMAKE_C_FLAGS};${DKCMAKE_C_FLAGS})
#dk_set						(CMAKE_C_FLAGS_DEBUG		${CMAKE_C_FLAGS_DEBUG} ${DKCMAKE_C_FLAGS_DEBUG})
#dk_set						(CMAKE_C_FLAGS_RELEASE		${CMAKE_C_FLAGS_RELEASE} ${DKCMAKE_C_FLAGS_RELEASE})
#dk_set						(CMAKE_CXX_FLAGS			${CMAKE_CXX_FLAGS} ${DKCMAKE_CXX_FLAGS})
#dk_set						(CMAKE_CXX_FLAGS_DEBUG		${CMAKE_CXX_FLAGS_DEBUG} ${DKCMAKE_CXX_FLAGS_DEBUG})
#dk_set						(CMAKE_CXX_FLAGS_RELEASE	${CMAKE_CXX_FLAGS_RELEASE} ${DKCMAKE_CXX_FLAGS_RELEASE})
#LINUX_DEBUG_dk_set			(CMAKE_C_FLAGS				${CMAKE_C_FLAGS} ${DKCMAKE_C_FLAGS_DEBUG})
#LINUX_DEBUG_dk_set			(CMAKE_CXX_FLAGS			${CMAKE_CXX_FLAGS} ${DKCMAKE_CXX_FLAGS_DEBUG})
#LINUX_RELEASE_dk_set		(CMAKE_C_FLAGS				${CMAKE_C_FLAGS} ${DKCMAKE_C_FLAGS_RELEASE})
#LINUX_RELEASE_dk_set		(CMAKE_CXX_FLAGS			${CMAKE_CXX_FLAGS} ${DKCMAKE_CXX_FLAGS_RELEASE})
#RASPBERRY_DEBUG_dk_set		(CMAKE_C_FLAGS				${CMAKE_C_FLAGS} ${DKCMAKE_C_FLAGS_DEBUG})
#RASPBERRY_DEBUG_dk_set		(CMAKE_CXX_FLAGS			${CMAKE_CXX_FLAGS} ${DKCMAKE_CXX_FLAGS_DEBUG})
#RASPBERRY_RELEASE_dk_set	(CMAKE_C_FLAGS				${CMAKE_C_FLAGS} ${DKCMAKE_C_FLAGS_RELEASE})
#RASPBERRY_RELEASE_dk_set	(CMAKE_CXX_FLAGS			${CMAKE_CXX_FLAGS} ${DKCMAKE_CXX_FLAGS_RELEASE})
list(APPEND CMAKE_C_FLAGS 			${DKCMAKE_C_FLAGS})
list(APPEND CMAKE_C_FLAGS_DEBUG 	${DKCMAKE_C_FLAGS_DEBUG})
list(APPEND CMAKE_C_FLAGS_RELEASE 	${DKCMAKE_C_FLAGS_RELEASE})
list(APPEND CMAKE_CXX_FLAGS 		${DKCMAKE_CXX_FLAGS})
list(APPEND CMAKE_CXX_FLAGS_DEBUG 	${DKCMAKE_CXX_FLAGS_DEBUG})
list(APPEND CMAKE_CXX_FLAGS_RELEASE ${DKCMAKE_CXX_FLAGS_RELEASE})
if(LINUX OR RASPBERRY)
	if(DEBUG)
		list(APPEND CMAKE_C_FLAGS 	${DKCMAKE_C_FLAGS_DEBUG})
		list(APPEND CMAKE_CXX_FLAGS ${DKCMAKE_CXX_FLAGS_DEBUG})
	elseif(RELEASE)
		list(APPEND CMAKE_C_FLAGS 	${DKCMAKE_C_FLAGS_RELEASE})
		list(APPEND CMAKE_CXX_FLAGS ${DKCMAKE_CXX_FLAGS_RELEASE})
	endif()
endif()





if(DKCMAKE_C_FLAGS)
	#dk_set		(DKCMAKE_FLAGS ${DKCMAKE_FLAGS} -DCMAKE_C_FLAGS=${DKCMAKE_C_FLAGS})
	list(APPEND DKCMAKE_FLAGS -DCMAKE_C_FLAGS=${DKCMAKE_C_FLAGS})
endif()
if(DKCMAKE_CXX_FLAGS)
	#dk_set		(DKCMAKE_FLAGS ${DKCMAKE_FLAGS} -DCMAKE_CXX_FLAGS=${DKCMAKE_CXX_FLAGS})
	list(APPEND DKCMAKE_FLAGS -DCMAKE_CXX_FLAGS=${DKCMAKE_CXX_FLAGS})
endif()
if(NOT LINUX AND NOT RASPBERRY)
	if(DKCMAKE_C_FLAGS_DEBUG)
		#dk_set	(DKCMAKE_FLAGS ${DKCMAKE_FLAGS} -DCMAKE_C_FLAGS_DEBUG=${DKCMAKE_C_FLAGS_DEBUG})
		list(APPEND DKCMAKE_FLAGS -DCMAKE_C_FLAGS_DEBUG=${DKCMAKE_C_FLAGS_DEBUG})
	endif()
	if(DKCMAKE_C_FLAGS_RELEASE)
		#dk_set	(DKCMAKE_FLAGS ${DKCMAKE_FLAGS} -DCMAKE_C_FLAGS_RELEASE=${DKCMAKE_C_FLAGS_RELEASE})
		list(APPEND DKCMAKE_FLAGS -DCMAKE_C_FLAGS_RELEASE=${DKCMAKE_C_FLAGS_RELEASE})
	endif()
	if(DKCMAKE_CXX_FLAGS_DEBUG)
		#dk_set	(DKCMAKE_FLAGS ${DKCMAKE_FLAGS} -DCMAKE_CXX_FLAGS_DEBUG=${DKCMAKE_CXX_FLAGS_DEBUG})
		list(APPEND DKCMAKE_FLAGS -DCMAKE_CXX_FLAGS_DEBUG=${DKCMAKE_CXX_FLAGS_DEBUG})
	endif()
	if(DKCMAKE_CXX_FLAGS_RELEASE)
		#dk_set	(DKCMAKE_FLAGS ${DKCMAKE_FLAGS} -DCMAKE_CXX_FLAGS_RELEASE=${DKCMAKE_CXX_FLAGS_RELEASE})
		list(APPEND DKCMAKE_FLAGS -DCMAKE_CXX_FLAGS_RELEASE=${DKCMAKE_CXX_FLAGS_RELEASE})
	endif()
endif()



if(DKCONFIGURE_CC)
	#dk_set			(DKCONFIGURE_FLAGS ${DKCONFIGURE_FLAGS} CC=${DKCONFIGURE_CC})
	list(APPEND DKCONFIGURE_FLAGS CC=${DKCONFIGURE_CC})
endif()
if(DKCONFIGURE_CXX)
	#dk_set			(DKCONFIGURE_FLAGS ${DKCONFIGURE_FLAGS} CXX=${DKCONFIGURE_CXX})
	list(APPEND DKCONFIGURE_FLAGS CXX=${DKCONFIGURE_CXX})
endif()
if(WIN)
	if(DKCONFIGURE_CFLAGS)
		#WIN_dk_set	(DKCONFIGURE_FLAGS ${DKCONFIGURE_FLAGS} CFLAGS=${DKCONFIGURE_CFLAGS})
		list(APPEND DKCONFIGURE_FLAGS CFLAGS=${DKCONFIGURE_CFLAGS})
	endif()
	if(DKCONFIGURE_CXXFLAGS)
		#WIN_dk_set	(DKCONFIGURE_FLAGS ${DKCONFIGURE_FLAGS} CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
		list(APPEND DKCONFIGURE_FLAGS CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
	endif()
else()
	if(DKCONFIGURE_CFLAGS)
		#dk_set		(DKCONFIGURE_FLAGS ${DKCONFIGURE_FLAGS} CFLAGS=${DKCONFIGURE_CFLAGS})
		list(APPEND DKCONFIGURE_FLAGS CFLAGS=${DKCONFIGURE_CFLAGS})
	endif()
	if(DKCONFIGURE_CXXFLAGS)
		#dk_set		(DKCONFIGURE_FLAGS ${DKCONFIGURE_FLAGS} CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
		list(APPEND DKCONFIGURE_FLAGS CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
	endif()
endif()




# FIXME: This is incorrect. Build directory goes by IDE/compiler, not OS
# Here's the list

# COMPILER                 Build_root         Target configs
# ---------------------------------------------------
# VisualStudio_cl           ${OS}             /multiple      /win
# VisualStudio clang/++     ${OS}             /multi
# XCode_clang/++            ${OS}             /multi
# MinGW_gcc/++              ${OS}/${TYPE}     /single        /win   for example, win can be multiple or single 
# Linux_gcc/++              ${OS}/${TYPE}     /single
# RaspberryPi_gcc/++        ${OS}/${TYPE}     /single           
# ./configure               ${OS}/${TYPE}     /single

if(LINUX OR RASPBERRY)
	if(DEBUG)
		dk_set	(CMAKE_BUILD_TYPE DEBUG)
		dk_set	(BUILD_DIR ${OS}/${DEBUG_DIR})
	elseif(RELEASE)
		dk_set	(CMAKE_BUILD_TYPE RELEASE)
		dk_set	(BUILD_DIR ${OS}/${RELEASE_DIR})
	endif()
else()
	dk_set		(CMAKE_BUILD_TYPE DEBUG RELEASE)
	dk_set		(BUILD_DIR ${OS})
endif()


############ CORE DEPENDENCIES ############
dk_depend	(git)
dk_depend	(cmake)

### WINDOWS ###	
WIN_dk_depend	(visualstudio)
WIN_dk_depend	(imagemagick)

WIN32_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A Win32 ${DKCMAKE_FLAGS})
WIN64_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A x64 ${DKCMAKE_FLAGS})
WIN_dk_set		(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})

### MAC ###
MAC_HOST_dk_depend	(xcode)
MAC_HOST_dk_set		(DKCMAKE_BUILD ${CMAKE_COMMAND} -G "Xcode" -T buildsystem=1 ${DKCMAKE_FLAGS})
MAC_HOST_dk_set		(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})

### LINUX ###
#LINUX_dk_depend(kdevelop)
LINUX_dk_depend			(libx11-dev)
LINUX_dk_lib			(pthread)
LINUX_dk_lib			(dl)
LINUX_dk_lib			(libstdc++fs.a)
LINUX_DEBUG_dk_set		(DKCMAKE_BUILD ${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug ${DKCMAKE_FLAGS})
LINUX_RELEASE_dk_set	(DKCMAKE_BUILD ${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ${DKCMAKE_FLAGS})
LINUX_dk_set			(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})  

### RASPBERRY ###
RASPBERRY_dk_depend			(libx11-dev)
RASPBERRY_dk_lib			(pthread)
RASPBERRY_dk_lib			(dl)
RASPBERRY_dk_lib			(libstdc++fs.a)
RASPBERRY_dk_linkDir		(/opt/vc/lib)
RASPBERRY_dk_lib			(bcm_host)
RASPBERRY_DEBUG_dk_set		(DKCMAKE_BUILD ${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug ${DKCMAKE_FLAGS})
RASPBERRY_RELEASE_dk_set	(DKCMAKE_BUILD ${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ${DKCMAKE_FLAGS})
RASPBERRY_dk_set			(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})  

### ANDROID ###
ANDROID_dk_lib		(dl)
ANDROID_dk_lib		(log)
ANDROID_dk_lib		(android)
ANDROID_dk_lib		(m)
ANDROID_dk_depend	(jdk8)
ANDROID_dk_depend	(jdk)
ANDROID_dk_depend	(ant)
ANDROID_dk_depend	(android-sdk)
#ANDROID_dk_depend	(android-studio)
ANDROID_dk_depend	(android-ndk)
ANDROID_dk_depend	(android-cmake)
ANDROID_dk_depend	(visualstudio)
ANDROID32_dk_depend	(mingw32)
ANDROID64_dk_depend	(mingw64)
ANDROID_dk_depend	(msys2)
ANDROID_dk_depend	(openssl)
ANDROID_dk_depend	(openssl_binary)

#if(WIN_HOST)
	ANDROID32_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A ARM ${DKCMAKE_FLAGS})
	ANDROID64_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A ARM64 ${DKCMAKE_FLAGS})
#endif()
ANDROID_dk_set		(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
