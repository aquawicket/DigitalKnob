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
# x86_32
# x86_64
# arm_32
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
dk_depend(cmake)
if(MSVC)
	WIN_HOST_dk_depend(visualstudio)
endif()
if(MSYS)
	WIN_HOST_dk_depend(msys2)
	WIN_HOST_dk_depend(gcc)
	set(INCLUDE_DKPLUGINS 0) # TODO - INCLUDE_DKPLUGINS not working on MSYS
endif()
if(XCODE)
	MAC_HOST_dk_depend(xcode)
endif()
LINUX_HOST_dk_depend(gcc)
ANDROID_dk_depend(android-ndk)
EMSCRIPTEN_dk_depend(emsdk)


### User Friendly Options ###
dk_set(BUILD_SHARED_LIBS				OFF)
dk_set(BUILD_STATIC_LIBS				ON)
dk_set(ENABLE_EXCEPTIONS				ON)    
dk_set(ENABLE_RTTI						ON)
dk_set(POSITION_INDEPENDENT_CODE 		ON)
dk_set(POSITION_INDEPENDENT_EXECUTABLE 	OFF)                                        
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
	WIN_dk_set(DKCMAKE_C_FLAGS_DEBUG			"/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG")
	WIN_dk_set(DKCMAKE_C_FLAGS_RELEASE			"/MT /O2 /Ob2 /DNDEBUG")
	WIN_dk_set(DKCMAKE_CXX_FLAGS_DEBUG			"/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG")
	WIN_dk_set(DKCMAKE_CXX_FLAGS_RELEASE		"/MT /O2 /Ob2 /DNDEBUG")
else()
	dk_set(DKCMAKE_C_FLAGS_DEBUG				"-DDEBUG -D_DEBUG -g")
	dk_set(DKCMAKE_C_FLAGS_RELEASE				"-O3 -DNDEBUG")
	dk_set(DKCMAKE_CXX_FLAGS_DEBUG				"-DDEBUG -D_DEBUG -g")
	dk_set(DKCMAKE_CXX_FLAGS_RELEASE			"-O3 -DNDEBUG")
endif()
dk_set(DKCONFIGURE_CFLAGS_DEBUG					"-DDEBUG -D_DEBUG -g")
dk_set(DKCONFIGURE_CFLAGS_RELEASE				"-O3 -DNDEBUG")
dk_set(DKCONFIGURE_CXXFLAGS_DEBUG				"-DDEBUG -D_DEBUG -g")
dk_set(DKCONFIGURE_CXXFLAGS_RELEASE				"-O3 -DNDEBUG")

if(POSITION_INDEPENDENT_CODE)
	if(MSVC AND WIN)
		
	else()
		dk_append(DKCMAKE_C_FLAGS "-fPIC")
		dk_append(DKCMAKE_CXX_FLAGS "-fPIC")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-fPIC") 
	dk_append(DKCONFIGURE_CXXFLAGS "-fPIC") 
else()	
	if(MSVC AND WIN)
		
	else()
		dk_append(DKCMAKE_C_FLAGS "-fno-pic")
		dk_append(DKCMAKE_CXX_FLAGS "-fno-pic")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-fno-pic") 
	dk_append(DKCONFIGURE_CXXFLAGS "-fno-pic") 
endif()

if(POSITION_INDEPENDENT_EXECUTABLE)
	if(MSVC AND WIN)
	
	else()
		dk_append(DKCMAKE_C_FLAGS "-pie")
		dk_append(DKCMAKE_CXX_FLAGS "-pie")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-pie") 
	dk_append(DKCONFIGURE_CXXFLAGS "-pie") 
else()
	if(MSVC AND WIN)
	
	else()
		dk_append(DKCMAKE_C_FLAGS "-no-pie")
		dk_append(DKCMAKE_CXX_FLAGS "-no-pie")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-no-pie") 
	dk_append(DKCONFIGURE_CXXFLAGS "-no-pie") 
endif()

if(ENABLE_RTTI)
	if(MSVC AND WIN)
		dk_append(DKCMAKE_CXX_FLAGS "/GR")
	else()
		dk_append(DKCMAKE_CXX_FLAGS "-frtti")
	endif()
	dk_append(DKCONFIGURE_CXXFLAGS "-frtti")
else()
	if(MSVC AND WIN)
		dk_append(DKCMAKE_C_FLAGS "/GR-")
		dk_append(DKCMAKE_CXX_FLAGS "/GR-")
	else()
		dk_append(DKCMAKE_C_FLAGS "-fno-rtti")
		dk_append(DKCMAKE_CXX_FLAGS "-fno-rtti")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-fno-rtti") 
	dk_append(DKCONFIGURE_CXXFLAGS "-fno-rtti")
endif()

if(ENABLE_EXCEPTIONS)
	if(MSVC AND WIN)
		dk_append(DKCMAKE_C_FLAGS "/EHsc")
		dk_append(DKCMAKE_CXX_FLAGS "/EHsc")
	else()
		dk_append(DKCMAKE_C_FLAGS "-fexceptions")
		dk_append(DKCMAKE_CXX_FLAGS "-fexceptions")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-fexceptions") 
	dk_append(DKCONFIGURE_CXXFLAGS "-fexceptions")
else()
	if(MSVC AND WIN)
		dk_append(DKCMAKE_C_FLAGS "/D_HAS_EXCEPTIONS=0")
		dk_append(DKCMAKE_CXX_FLAGS "/D_HAS_EXCEPTIONS=0")
	else()
		dk_append(DKCMAKE_C_FLAGS "-fno-exceptions")
		dk_append(DKCMAKE_CXX_FLAGS "-fno-exceptions")
	endif()
	dk_append(DKCONFIGURE_CFLAGS "-fno-exceptions") 
	dk_append(DKCONFIGURE_CXXFLAGS "-fno-exceptions")
endif()


# Windows i686 (x32) - MSVC / MSYS
if(MSVC)
	WIN_X86_dk_set(DKCMAKE_C_COMPILER				"${VISUALSTUDIO_X86_C_COMPILER}")
	WIN_X86_dk_append(DKCMAKE_C_FLAGS				"/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj") # /D_WIN32_WINNT=0x0600
	WIN_X86_dk_set(DKCMAKE_CXX_COMPILER			"${VISUALSTUDIO_X86_CXX_COMPILER}")
	WIN_X86_dk_append(DKCMAKE_CXX_FLAGS			"/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj") # /D_WIN32_WINNT=0x0600
elseif(MSYS)
	WIN_X86_dk_set(DKCMAKE_C_COMPILER				"${GCC_C_COMPILER}")
	WIN_X86_dk_append(DKCMAKE_C_FLAGS				"-march=i686 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17")
	WIN_X86_dk_set(DKCMAKE_CXX_COMPILER			"${GCC_CXX_COMPILER}")
	WIN_X86_dk_append(DKCMAKE_CXX_FLAGS			"-march=i686 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17")
endif()
WIN_X86_dk_append(DKCONFIGURE_FLAGS				--build=i686-w64-mingw32)
WIN_X86_dk_append(DKCONFIGURE_CFLAGS				"-march=i686 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17") # -D_WIN32_WINNT=0x0600 
WIN_X86_dk_append(DKCONFIGURE_CXXFLAGS			"-march=i686 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17") # -D_WIN32_WINNT=0x0600

# Windows x86_64 (x64) - MSVC / MSYS
if(MSVC)
	WIN_X86_64_dk_set(DKCMAKE_C_COMPILER				"${VISUALSTUDIO_X64_C_COMPILER}")
	WIN_X86_64_dk_append(DKCMAKE_C_FLAGS				"/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj") #/MACHINE:X64 /D_WIN32_WINNT=0x0600
	WIN_X86_64_dk_set(DKCMAKE_CXX_COMPILER			"${VISUALSTUDIO_X64_CXX_COMPILER}")
	WIN_X86_64_dk_append(DKCMAKE_CXX_FLAGS			"/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj") #/MACHINE:X64 /D_WIN32_WINNT=0x0600
elseif(MSYS)
	WIN_X86_64_dk_set(DKCMAKE_C_COMPILER				"${GCC_C_COMPILER}")
	WIN_X86_64_dk_append(DKCMAKE_C_FLAGS				"-march=x86-64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_WIN32_WINNT=0x0600 -D_USING_V110_SDK71_ -std=gnu17")
	WIN_X86_64_dk_set(DKCMAKE_CXX_COMPILER			"${GCC_CXX_COMPILER}")
	WIN_X86_64_dk_append(DKCMAKE_CXX_FLAGS			"-march=x86-64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_WIN32_WINNT=0x0600 -D_USING_V110_SDK71_ -std=gnu++17")
endif()
WIN_X86_64_dk_append(DKCONFIGURE_FLAGS				--build=x86_64-w64-mingw32)
WIN_X86_64_dk_append(DKCONFIGURE_CFLAGS				"-march=x86-64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_WIN32_WINNT=0x0600 -D_USING_V110_SDK71_ -std=gnu17")
WIN_X86_64_dk_append(DKCONFIGURE_CXXFLAGS			"-march=x86-64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_WIN32_WINNT=0x0600 -D_USING_V110_SDK71_ -std=gnu++17")

# Moc i686 (x32) - XCODE
if(XCODE)
	MAC_X86_dk_append(DKCMAKE_FLAGS				-DCMAKE_OSX_ARCHITECTURES=x86)
	MAC_X86_dk_set(DKCMAKE_C_COMPILER				${XCODE_C_COMPILER})
	MAC_X86_dk_append(DKCMAKE_C_FLAGS				"-DMAC -DMAC_X86 -std=c17 -x objective-c")
	MAC_X86_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CXX_COMPILER})
	MAC_X86_dk_append(DKCMAKE_CXX_FLAGS			"-DMAC -DMAC_X86 -std=c++17 -x objective-c++")
	#MAC_X86_dk_set(DKCONFIGURE_CC				${XCODE_C_COMPILER})
	MAC_X86_dk_append(DKCONFIGURE_CFLAGS			"-arch i686 -DMAC -DMAC_X86 -std=c17") #-x objective-c") # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
	#MAC_X86_dk_set(DKCONFIGURE_CXX				${XCODE_CXX_COMPILER})
	MAC_X86_dk_append(DKCONFIGURE_CXXFLAGS		"-arch i686 -DMAC -DMAC_X86 -std=c++17 -x objective-c++") #-x objective-c++") # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
endif()

# Moc x86_64 (x64) - XCODE
if(XCODE)
	MAC_X86_64_dk_append(DKCMAKE_FLAGS				-DCMAKE_OSX_ARCHITECTURES=x86_64)
	MAC_X86_64_dk_set(DKCMAKE_C_COMPILER				${XCODE_C_COMPILER})
	MAC_X86_64_dk_append(DKCMAKE_C_FLAGS				"-DMAC -DMAC_X86_64 -std=c17 -x objective-c")
	MAC_X86_64_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CXX_COMPILER})
	MAC_X86_64_dk_append(DKCMAKE_CXX_FLAGS			"-DMAC -DMAC_X86_64 -std=c++17 -x objective-c++")
	#MAC_X86_64_dk_set(DKCONFIGURE_CC				${XCODE_C_COMPILER})
	MAC_X86_64_dk_append(DKCONFIGURE_CFLAGS			"-DMAC -DMAC_X86_64 -std=c17") #-x objective-c") # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
	#MAC_X86_64_dk_set(DKCONFIGURE_CXX				${XCODE_CXX_COMPILER})
	MAC_X86_64_dk_append(DKCONFIGURE_CXXFLAGS		"-DMAC -DMAC_X86_64 -std=c++17") #-x objective-c++") #https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
endif()

# iOS arm (x32) - XCODE
IOS_ARM32_dk_append(DKCMAKE_FLAGS					-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm)
#IOS_ARM32_dk_set(DKCMAKE_C_COMPILER				${XCODE_C_COMPILER})
IOS_ARM32_dk_append(DKCMAKE_C_FLAGS					"-DIOS -DIOS_ARM32 -std=c17 -x objective-c")
#IOS_ARM32_dk_set(DKCMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
IOS_ARM32_dk_append(DKCMAKE_CXX_FLAGS				"-DIOS -DIOS_ARM32 -std=c++17 -x objective-c++")
IOS_ARM32_dk_append(DKCONFIGURE_FLAGS				--host arm-apple-${IOS_DARWIN})
IOS_ARM32_dk_set(DKCONFIGURE_CC						${XCODE_C_COMPILER})
IOS_ARM32_dk_append(DKCONFIGURE_CFLAGS				"-arch arm -DIOS -DIOS_ARM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT}")
IOS_ARM32_dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
IOS_ARM32_dk_append(DKCONFIGURE_CXXFLAGS			"-arch arm -DIOS -DIOS_ARM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT}")

# iOS arm64 (x64) - XCODE
IOS_ARM64_dk_append(DKCMAKE_FLAGS					-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS64 -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm64)
#IOS_ARM64_dk_set(DKCMAKE_C_COMPILER				${XCODE_C_COMPILER})
IOS_ARM64_dk_append(DKCMAKE_C_FLAGS					"-DIOS -DIOS_ARM64 -std=c17 -x objective-c")
#IOS_ARM64_dk_set(DKCMAKE_CXX_COMPILER				${XCODE_CXX_COMPILER})
IOS_ARM64_dk_append(DKCMAKE_CXX_FLAGS				"-DIOS -DIOS_ARM64 -std=c++17 -x objective-c++")
IOS_ARM64_dk_append(DKCONFIGURE_FLAGS				--host arm64-apple-${IOS_DARWIN})
IOS_ARM64_dk_set(DKCONFIGURE_CC						${XCODE_C_COMPILER})
IOS_ARM64_dk_append(DKCONFIGURE_CFLAGS				"-arch arm64 -DIOS -DIOS_ARM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT}")
IOS_ARM64_dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
IOS_ARM64_dk_append(DKCONFIGURE_CXXFLAGS			"-arch arm64 -DIOS -DIOS_ARM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT}")

# iOS Simulator i686 (x32) - XCODE
IOSSIM_X86_dk_append(DKCMAKE_FLAGS				-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=SIMULATOR -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=i686)
#IOSSIM_X86_dk_set(DKCMAKE_C_COMPILER				${XCODE_C_COMPILER})
IOSSIM_X86_dk_append(DKCMAKE_C_FLAGS				"-DIOS -DIOS_ARM32 -DIOSSIM -DIOSSIM_X86 -std=c17 -x objective-c")
#IOSSIM_X86_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CXX_COMPILER})
IOSSIM_X86_dk_append(DKCMAKE_CXX_FLAGS			"-DIOS -DIOS_ARM32 -DIOSSIM -DIOSSIM_X86 -std=c++17 -x objective-c++")
IOSSIM_X86_dk_append(DKCONFIGURE_FLAGS			--host i686-apple-${IOS_DARWIN})
IOSSIM_X86_dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
IOSSIM_X86_dk_append(DKCONFIGURE_CFLAGS			"-arch i686 -DIOS -DIOS_ARM32 -DIOSSIM -DIOSSIM_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT}")
IOSSIM_X86_dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
IOSSIM_X86_dk_append(DKCONFIGURE_CXXFLAGS			"-arch i686 -DIOS -DIOS_ARM32 -DIOSSIM -DIOSSIM_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT}")

# iOS Simulator x86_64 (x64) - XCODE
IOSSIM_X86_64_dk_append(DKCMAKE_FLAGS				-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake -DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=SIMULATOR64 -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=x86_64)
#IOSSIM_X86_64_dk_set(DKCMAKE_C_COMPILER				${XCODE_C_COMPILER})
IOSSIM_X86_64_dk_append(DKCMAKE_C_FLAGS				"-DIOS -DIOS_ARM64 -DIOSSIM -DIOSSIM_X86_64 -std=c17 -x objective-c")
#IOSSIM_X86_64_dk_set(DKCMAKE_CXX_COMPILER			${XCODE_CXX_COMPILER})
IOSSIM_X86_64_dk_append(DKCMAKE_CXX_FLAGS			"-DIOS -DIOS_ARM64 -DIOSSIM -DIOSSIM_X86_64 -std=c++17 -x objective-c++")
IOSSIM_X86_64_dk_append(DKCONFIGURE_FLAGS			--host x86_64-apple-${IOS_DARWIN})
IOSSIM_X86_64_dk_set(DKCONFIGURE_CC					${XCODE_C_COMPILER})
IOSSIM_X86_64_dk_append(DKCONFIGURE_CFLAGS			"-arch x86_64 -DIOS -DIOS_ARM64 -DIOSSIM -DIOSSIM_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT}")
IOSSIM_X86_64_dk_set(DKCONFIGURE_CXX					${XCODE_CXX_COMPILER})
IOSSIM_X86_64_dk_append(DKCONFIGURE_CXXFLAGS			"-arch x86_64 -DIOS -DIOS_ARM64 -DIOSSIM -DIOSSIM_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT}")

# Linux i686 (x32) - GCC
LINUX_X86_dk_set(DKCMAKE_C_COMPILER				${GCC_C_COMPILER})
LINUX_X86_dk_append(DKCMAKE_C_FLAGS				"-march=i686 -DLINUX -DLINUX_X86 -std=gnu11")
LINUX_X86_dk_set(DKCMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
LINUX_X86_dk_append(DKCMAKE_CXX_FLAGS				"-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs")
LINUX_X86_dk_set(DKCONFIGURE_CC					${GCC_C_COMPILER})
LINUX_X86_dk_append(DKCONFIGURE_CFLAGS			"-march=i686 -DLINUX -DLINUX_X86 -std=gnu11")
LINUX_X86_dk_set(DKCONFIGURE_CXX					${GCC_CXX_COMPILER})
LINUX_X86_dk_append(DKCONFIGURE_CXXFLAGS			"-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs")

# Linux x86_64 (x64) - GCC
LINUX_X86_64_dk_set(DKCMAKE_C_COMPILER				${GCC_C_COMPILER})
LINUX_X86_64_dk_append(DKCMAKE_C_FLAGS				"-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11")
LINUX_X86_64_dk_set(DKCMAKE_CXX_COMPILER				${GCC_CXX_COMPILER})
LINUX_X86_64_dk_append(DKCMAKE_CXX_FLAGS				"-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs")
LINUX_X86_64_dk_set(DKCONFIGURE_CC					${GCC_C_COMPILER})
LINUX_X86_64_dk_append(DKCONFIGURE_CFLAGS			"-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11")
LINUX_X86_64_dk_set(DKCONFIGURE_CXX					${GCC_CXX_COMPILER})
LINUX_X86_64_dk_append(DKCONFIGURE_CXXFLAGS			"-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs")

# Raspbery arm (x32) - GCC
RASPBERRY_ARM32_dk_set(DKCMAKE_C_COMPILER			${GCC_C_COMPILER})
RASPBERRY_ARM32_dk_append(DKCMAKE_C_FLAGS			"-DLINUX -DLINUX_X86 -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11") #-march=armv7l
RASPBERRY_ARM32_dk_set(DKCMAKE_CXX_COMPILER			${GCC_CXX_COMPILER})
RASPBERRY_ARM32_dk_append(DKCMAKE_CXX_FLAGS			"-DLINUX -DLINUX_X86 -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs") #-march=armv7l 
RASPBERRY_ARM32_dk_set(DKCONFIGURE_CC				${GCC_C_COMPILER})
RASPBERRY_ARM32_dk_append(DKCONFIGURE_CFLAGS		"-DLINUX -DLINUX_X86 -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11") #-march=armv7l 
RASPBERRY_ARM32_dk_set(DKCONFIGURE_CXX				${GCC_CXX_COMPILER})
RASPBERRY_ARM32_dk_append(DKCONFIGURE_CXXFLAGS		"-DLINUX -DLINUX_X86 -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs") #-march=armv7l 

# Raspbery arm64 (x64) - GCC
RASPBERRY_ARM64_dk_set(DKCMAKE_C_COMPILER			${GCC_C_COMPILER})
RASPBERRY_ARM64_dk_append(DKCMAKE_C_FLAGS			"-DLINUX -DLINUX_X86_64 -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu11") #-march=armv7l 
RASPBERRY_ARM64_dk_set(DKCMAKE_CXX_COMPILER			${GCC_CXX_COMPILER})
RASPBERRY_ARM64_dk_append(DKCMAKE_CXX_FLAGS			"-DLINUX -DLINUX_X86_64 -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu++17 -lstdc++fs") #-march=armv7l 
RASPBERRY_ARM64_dk_set(DKCONFIGURE_CC				${GCC_C_COMPILER})
RASPBERRY_ARM64_dk_append(DKCONFIGURE_CFLAGS		"-DLINUX -DLINUX_X86_64 -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu11") #-march=armv7l 
RASPBERRY_ARM64_dk_set(DKCONFIGURE_CXX				${GCC_CXX_COMPILER})
RASPBERRY_ARM64_dk_append(DKCONFIGURE_CXXFLAGS		"-DLINUX -DLINUX_X86_64 -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu++17 -lstdc++fs") #-march=armv7l 

# Android armeabi-v7a (x32) - CLANG
ANDROID_ARM32_dk_set(CMAKE_GENERATOR				"Unix Makefiles")
ANDROID_ARM32_dk_append(DKCMAKE_FLAGS
	-DANDROID_ABI=armeabi-v7a
	"-DANDROID_CPP_FEATURES=rtti exceptions"
	-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
	-DANDROID_NDK=${ANDROID_NDK}
	-DANDROID_PLATFORM=${ANDROID_API}
	-DANDROID_STL=c++_static
	-DANDROID_STL_FORCE_FEATURES=1
	-DANDROID_TOOLCHAIN=clang
	-DCMAKE_ANDROID_STL_TYPE=c++_static
	-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake
	-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM})
#ANDROID_ARM32_dk_set(DKCMAKE_C_COMPILER			${ANDROID_NDK_C_COMPILER})
ANDROID_ARM32_dk_append(DKCMAKE_C_FLAGS				"-DANDROID -DANDROID_ARM32 -std=c17") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID_ARM32_dk_set(DKCMAKE_CXX_COMPILER			${ANDROID_NDK_CXX_COMPILER})
ANDROID_ARM32_dk_append(DKCMAKE_CXX_FLAGS			"-DANDROID -DANDROID_ARM32 -std=c++1z") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID_ARM32_dk_set(DKCONFIGURE_CC				${ANDROID_NDK_C_COMPILER})
ANDROID_ARM32_dk_append(DKCONFIGURE_CFLAGS			"-DANDROID -DANDROID_ARM32 -std=c17") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID_ARM32_dk_set(DKCONFIGURE_CXX				${ANDROID_NDK_CXX_COMPILER})
ANDROID_ARM32_dk_append(DKCONFIGURE_CXXFLAGS		"-DANDROID -DANDROID_ARM32 -std=c++1z") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined

# Android arm64-v8a (x64) - CLANG
ANDROID_ARM64_dk_append(DKCMAKE_FLAGS 
	-DANDROID_ABI=arm64-v8a
	"-DANDROID_CPP_FEATURES=rtti exceptions"
	-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
	-DANDROID_NDK=${ANDROID_NDK}
	-DANDROID_PLATFORM=${ANDROID_API}
	-DANDROID_STL=c++_static
	-DANDROID_STL_FORCE_FEATURES=1
	-DANDROID_TOOLCHAIN=clang
	-DCMAKE_ANDROID_STL_TYPE=c++_static
	-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake
	-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM})
#ANDROID_ARM64_dk_set(DKCMAKE_C_COMPILER			${ANDROID_NDK_C_COMPILER})
ANDROID_ARM64_dk_append(DKCMAKE_C_FLAGS				"-DANDROID -DANDROID_ARM64 -std=c17") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID_ARM64_dk_append(DKCMAKE_C_FLAGS_DEBUG		"-DDEBUG -D_DEBUG -frtti -fexceptions -g")
#ANDROID_ARM64_dk_append(DKCMAKE_C_FLAGS_RELEASE	"-DNDEBUG -frtti -fexceptions -O3")
#ANDROID_ARM64_dk_set(DKCMAKE_CXX_COMPILER			${ANDROID_NDK_CXX_COMPILER})
ANDROID_ARM64_dk_append(DKCMAKE_CXX_FLAGS			"-DANDROID -DANDROID_ARM64 -std=c++1z") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID_ARM64_dk_append(DKCMAKE_CXX_FLAGS_DEBUG	"-DDEBUG -D_DEBUG -frtti -fexceptions -g")
#ANDROID_ARM64_dk_append(DKCMAKE_CXX_FLAGS_RELEASE	"-DNDEBUG -frtti -fexceptions -O3")
#ANDROID_ARM64_dk_set(DKCONFIGURE_CC				${ANDROID_NDK_C_COMPILER})
ANDROID_ARM64_dk_append(DKCONFIGURE_CFLAGS			"-DANDROID -DANDROID_ARM64 -std=c17") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined
#ANDROID_ARM64_dk_set(DKCONFIGURE_CXX				${ANDROID_NDK_CXX_COMPILER})
ANDROID_ARM64_dk_append(DKCONFIGURE_CXXFLAGS		"-DANDROID -DANDROID_ARM64 -std=c++1z") #-U__ANDROID_API__ -D__ANDROID_API__=26 -Wno-macro-redefined

# Emscripten x32
EMSCRIPTEN_dk_append(DKCMAKE_FLAGS				-DEMSCRIPTEN=ON)
#EMSCRIPTEN_dk_set(DKCMAKE_C_COMPILER			${EMSDK_C_COMPILER})
EMSCRIPTEN_dk_append(DKCMAKE_C_FLAGS			"-DEMSCRIPTEN -std=gnu11")
#EMSCRIPTEN_dk_set(DKCMAKE_CXX_COMPILER			${EMSDK_CXX_COMPILER})
EMSCRIPTEN_dk_append(DKCMAKE_CXX_FLAGS			"-DEMSCRIPTEN -std=gnu++17")
#EMSCRIPTEN_dk_set(DKCONFIGURE_CC				${EMSDK_C_COMPILER})
EMSCRIPTEN_dk_append(DKCONFIGURE_CFLAGS			"-DEMSCRIPTEN -std=gnu11")
#EMSCRIPTEN_dk_set(DKCONFIGURE_CXX				${EMSDK_CXX_COMPILER})
EMSCRIPTEN_dk_append(DKCONFIGURE_CXXFLAGS		"-DEMSCRIPTEN -std=gnu++17")




######### Extra Flags and Settings #########
if(WARNINGS_AS_ERRORS)
	if(MSVC)
		WIN_dk_append	(DKCMAKE_C_FLAGS	"/WX")
		WIN_dk_append	(DKCMAKE_CXX_FLAGS	"/WX")
	else()
		dk_append		(DCMAKE_C_FLAGS		"-Werror")
		dk_append		(DCMAKE_CXX_FLAGS	"-Werror")
	endif()
endif()
if(WARNING_LEVEL)
	if(MSVC)
		WIN_dk_append	(DKCMAKE_C_FLAGS	"/W${WARNING_LEVEL}")
		WIN_dk_append	(DKCMAKE_CXX_FLAGS	"/W${WARNING_LEVEL}")
	endif()
endif()
if(WARNING_4244) # /wd4244 - Warning: possible loss of data 
	if(MSVC)
		WIN_dk_append	(DKCMAKE_C_FLAGS	"/wd4244")
		WIN_dk_append	(DKCMAKE_CXX_FLAGS	"/wd4244")
	endif()
endif()
if(WARNING_5105) # /wd5105 - macro producing defined is undefined behaviour
	if(MSVC)
		WIN_dk_append	(DKCMAKE_C_FLAGS	"/wd5105")
		WIN_dk_append	(DKCMAKE_CXX_FLAGS	"/wd5105")
	endif()
endif()


string(REPLACE ";" " " DKCMAKE_C_FLAGS "${DKCMAKE_C_FLAGS}")
string(REPLACE ";" " " DKCMAKE_C_FLAGS_DEBUG "${DKCMAKE_C_FLAGS_DEBUG}")
string(REPLACE ";" " " DKCMAKE_C_FLAGS_RELEASE "${DKCMAKE_C_FLAGS_RELEASE}")
string(REPLACE ";" " " DKCMAKE_CXX_FLAGS "${DKCMAKE_CXX_FLAGS}")
string(REPLACE ";" " " DKCMAKE_CXX_FLAGS_DEBUG "${DKCMAKE_CXX_FLAGS_DEBUG}")
string(REPLACE ";" " " DKCMAKE_CXX_FLAGS_RELEASE "${DKCMAKE_CXX_FLAGS_RELEASE}")
string(REPLACE ";" " " DKCONFIGURE_CFLAGS "${DKCONFIGURE_CFLAGS}")
string(REPLACE ";" " " DKCONFIGURE_CXXFLAGS "${DKCONFIGURE_CXXFLAGS}")


############## Setup continued by cmake from here ##############
if(DKCMAKE_C_COMPILER)
	dk_set					(CMAKE_C_COMPILER			${DKCMAKE_C_COMPILER})
endif()
if(DKCMAKE_CXX_COMPILER)
	dk_set					(CMAKE_CXX_COMPILER			${DKCMAKE_CXX_COMPILER})
endif()

dk_set						(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS})
dk_set						(CMAKE_C_FLAGS_DEBUG		${DKCMAKE_C_FLAGS_DEBUG})
dk_set						(CMAKE_C_FLAGS_RELEASE		${DKCMAKE_C_FLAGS_RELEASE})

dk_set						(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS})
dk_set						(CMAKE_CXX_FLAGS_DEBUG		${DKCMAKE_CXX_FLAGS_DEBUG})
dk_set						(CMAKE_CXX_FLAGS_RELEASE	${DKCMAKE_CXX_FLAGS_RELEASE})

#LINUX_DEBUG_dk_append		(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS_DEBUG})
#LINUX_DEBUG_dk_append		(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS_DEBUG})
#LINUX_RELEASE_dk_append	(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS_RELEASE})
#LINUX_RELEASE_dk_append	(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS_RELEASE})
#RASPBERRY_DEBUG_dk_append	(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS_DEBUG})
#RASPBERRY_DEBUG_dk_append	(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS_DEBUG})
#RASPBERRY_RELEASE_dk_append(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS_RELEASE})
#RASPBERRY_RELEASE_dk_append(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS_RELEASE})
#EMSCRIPTEN_DEBUG_dk_append	(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS_DEBUG})
#EMSCRIPTEN_DEBUG_dk_append	(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS_DEBUG})
#EMSCRIPTEN_RELEASE_dk_append(CMAKE_C_FLAGS				${DKCMAKE_C_FLAGS_RELEASE})
#EMSCRIPTEN_RELEASE_dk_append(CMAKE_CXX_FLAGS			${DKCMAKE_CXX_FLAGS_RELEASE})


if(DKCMAKE_C_FLAGS)
	dk_append		(DKCMAKE_FLAGS -DCMAKE_C_FLAGS=${DKCMAKE_C_FLAGS})
endif()
if(DKCMAKE_CXX_FLAGS)
	dk_append		(DKCMAKE_FLAGS -DCMAKE_CXX_FLAGS=${DKCMAKE_CXX_FLAGS})
endif()
if(NOT LINUX AND NOT RASPBERRY)
	if(DKCMAKE_C_FLAGS_DEBUG)
		dk_append	(DKCMAKE_FLAGS -DCMAKE_C_FLAGS_DEBUG=${DKCMAKE_C_FLAGS_DEBUG})
	endif()
	if(DKCMAKE_C_FLAGS_RELEASE)
		dk_append	(DKCMAKE_FLAGS -DCMAKE_C_FLAGS_RELEASE=${DKCMAKE_C_FLAGS_RELEASE})
	endif()
	if(DKCMAKE_CXX_FLAGS_DEBUG)
		dk_append	(DKCMAKE_FLAGS -DCMAKE_CXX_FLAGS_DEBUG=${DKCMAKE_CXX_FLAGS_DEBUG})
	endif()
	if(DKCMAKE_CXX_FLAGS_RELEASE)
		dk_append	(DKCMAKE_FLAGS -DCMAKE_CXX_FLAGS_RELEASE=${DKCMAKE_CXX_FLAGS_RELEASE})
	endif()
endif()



if(DKCONFIGURE_CC)
	dk_append		(DKCONFIGURE_FLAGS CC=${DKCONFIGURE_CC})
endif()
if(DKCONFIGURE_CXX)
	dk_append		(DKCONFIGURE_FLAGS CXX=${DKCONFIGURE_CXX})
endif()
#if(MSVC)
#	if(DKCONFIGURE_CFLAGS)
#		WIN_dk_append	(DKCONFIGURE_FLAGS CFLAGS="${DKCONFIGURE_CFLAGS}")
#	endif()
#	if(DKCONFIGURE_CXXFLAGS)
#		WIN_dk_append	(DKCONFIGURE_FLAGS CXXFLAGS="${DKCONFIGURE_CXXFLAGS}")
#	endif()
#else()
	if(DKCONFIGURE_CFLAGS)
		dk_append	(DKCONFIGURE_FLAGS CFLAGS=${DKCONFIGURE_CFLAGS})
	endif()
	if(DKCONFIGURE_CXXFLAGS)
		dk_append	(DKCONFIGURE_FLAGS CXXFLAGS=${DKCONFIGURE_CXXFLAGS})
	endif()
#endif()



# GENERATOR			BUILD_DIR		OUTPUT_DIR
# -----------------------------------------------
# Visual Studio  	${OS}			${OS}/${TYPE}		
# XCODE			    ${OS}			${OS}/${TYPE} 
# MinGW Makefiles   ${OS}/${TYPE}	${OS}/${TYPE} 
# Unix Makefiles    ${OS}/${TYPE}   ${OS}/${TYPE}  
# ./configure       ${OS}/${TYPE}   ${OS}/${TYPE}

# https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#build-configurations

if(MULTI_CONFIG)
	dk_set		(CMAKE_BUILD_TYPE DEBUG RELEASE)
	dk_set		(BUILD_DIR ${OS})
else()
	if(DEBUG)
		dk_set	(CMAKE_BUILD_TYPE DEBUG)
		dk_set	(BUILD_DIR ${OS}/${DEBUG_DIR})
	elseif(RELEASE)
		dk_set	(CMAKE_BUILD_TYPE RELEASE)
		dk_set	(BUILD_DIR ${OS}/${RELEASE_DIR})
	endif()
endif()








#if(VISUAL_STUDIO)
if(MSVC)
	WIN_X86_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A Win32 ${DKCMAKE_FLAGS})
	WIN_X86_64_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A x64 ${DKCMAKE_FLAGS})
else()
	WIN_DEBUG_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Debug ${DKCMAKE_FLAGS})
	WIN_RELEASE_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Release ${DKCMAKE_FLAGS})
endif()

MAC_HOST_dk_set				(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -T buildsystem=1 ${DKCMAKE_FLAGS})
LINUX_DEBUG_dk_set			(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Debug ${DKCMAKE_FLAGS})
LINUX_RELEASE_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Release ${DKCMAKE_FLAGS})
RASPBERRY_DEBUG_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Debug ${DKCMAKE_FLAGS})
RASPBERRY_RELEASE_dk_set	(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_BUILD_TYPE=Release ${DKCMAKE_FLAGS})


#if(VISUAL_STUDIO)
if(MSVC)
	ANDROID_ARM32_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A ARM ${DKCMAKE_FLAGS})
	ANDROID_ARM64_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -A ARM64 ${DKCMAKE_FLAGS})
else()
	ANDROID_ARM32_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
	ANDROID_ARM64_dk_set		(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
endif()


EMSCRIPTEN_DEBUG_dk_set		(DKCMAKE_BUILD ${EMSDK_ENV} & ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_TOOLCHAIN_FILE=${EMSDK_TOOLCHAIN_FILE} -DCMAKE_BUILD_TYPE=Debug ${DKCMAKE_FLAGS})
EMSCRIPTEN_RELEASE_dk_set	(DKCMAKE_BUILD ${EMSDK_ENV} & ${CMAKE_EXE} -G ${CMAKE_GENERATOR} -DCMAKE_TOOLCHAIN_FILE=${EMSDK_TOOLCHAIN_FILE} -DCMAKE_BUILD_TYPE=Release ${DKCMAKE_FLAGS})

if(EMSCRIPTEN)
	dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
else()
	dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
endif()


#dk_debug("DKCMAKE_BUILD = ${DKCMAKE_BUILD}")
