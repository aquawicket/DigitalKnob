if(DKBUILDTOOLS_INCLUDED)
  return()
endif(DKBUILDTOOLS_INCLUDED)
set(DKBUILDTOOLS_INCLUDED true)

### DEPENDS ###
DKDEPEND(git)
DKDEPEND(cmake)


### WINDOWS ###	
if(CMAKE_HOST_WIN32 AND WIN)
	DKDEPEND(visualstudio)
	DKDEPEND(imagemagick)
	
	##NOTE: When using /fsanitize=address,  /RTC1 is incompatable, so turn it off 
	## /EHsc   https://stackoverflow.com/a/4574319/688352
	
	# Windows 32
	DKSET(DKCMAKE_WIN32 ${CMAKE_EXE} -G ${VISUALSTUDIO_NAME} -A Win32 
	-DBUILD_SHARED_LIBS=OFF 
	"-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" 
	"-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" 
	"-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" 
	"-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" #/GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_
	"-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG"
	"-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG")

	# Windows 64
	DKSET(DKCMAKE_WIN64 ${CMAKE_EXE} -G ${VISUALSTUDIO_NAME} -A x64 
	-DBUILD_SHARED_LIBS=OFF 
	"-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo" 
	"-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" 
	"-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" 
	"-DCMAKE_CXX_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo" #/GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600 /MACHINE:X64
	"-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG"
	"-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG")
	
	DKSET(DKCONFIGURE_WIN32 ../../configure 
	--disable-shared 
	--enable-static 
	--build=i686-w64-mingw32 
	CFLAGS=-march=i686)
	
	DKSET(DKCONFIGURE_WIN64 ../../configure 
	--disable-shared 
	--enable-static 
	--build=x86_64-w64-mingw32 
	CFLAGS=-march=x86-64)
endif()


### APPLE ###
if(CMAKE_HOST_APPLE)
	DKDEPEND(xcode)
	
	# Mac 32
	DKSET(DKCMAKE_MAC32 ${CMAKE_EXE} -G "Xcode" 
	-DCMAKE_OSX_ARCHITECTURES=x86
	-DBUILD_SHARED_LIBS=OFF)

	# Mac 64
	DKSET(DKCMAKE_MAC64 ${CMAKE_EXE} -G "Xcode" 
	-DCMAKE_OSX_ARCHITECTURES=x86_64 
	-DBUILD_SHARED_LIBS=OFF) 

	# iOS 32
	DKSET(DKCMAKE_IOS32 ${CMAKE_EXE} -G "Xcode" 
	-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake 
	-DPLATFORM=OS
	-DSDK_VERSION=15.0 
	-DDEPLOYMENT_TARGET=13.0)

	# iOS 64
	DKSET(DKCMAKE_IOS64 ${CMAKE_EXE} -G "Xcode" 
	-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake 
	-DPLATFORM=OS64
	-DSDK_VERSION=15.0 
	-DDEPLOYMENT_TARGET=13.0)

	# iOS Simulator 32
	DKSET(DKCMAKE_IOSSIM32 ${CMAKE_EXE} -G "Xcode"
	-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake 
	-DPLATFORM=SIMULATOR
	-DSDK_VERSION=15.0 
	-DDEPLOYMENT_TARGET=13.0)

	# iOS Simulator 64
	DKSET(DKCMAKE_IOSSIM64 ${CMAKE_EXE} -G "Xcode"
	-DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/ios.toolchain.cmake 
	-DPLATFORM=SIMULATOR64
	-DSDK_VERSION=15.0 
	-DDEPLOYMENT_TARGET=13.0)

# SDK: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.0.sdk
# C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
# CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
# libtool: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool
# install name tool: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/install_name_tool
# Autoconf target triple: x86_64-apple-ios	
	
#AUTOTOOLS ../../configure for iOS
DKSET(IOS_ARCH x86_64)
DKSET(IOS_DARWIN darwin20.6.0)
DKSET(IOS_MIN_SDK_VERSION 13.0)
DKSET(XCODE_DEVROOT /Applications/Xcode.app/Contents/Developer)
DKSET(CLANG ${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang)
DKSET(CLANGXX ${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++)
DKSET(IOS_LIBTOOL ${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool)
DKSET(IOS_HOST ${IOS_ARCH}-apple-${IOS_DARWIN})
DKSET(IOS_SYSROOT ${XCODE_DEVROOT}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhone15.0.sdk)
DKSET(IOS_CFLAGS "-arch ${IOS_ARCH} -mios-simulator-version-min=${IOS_MIN_SDK_VERSION} -isysroot ${IOS_SYSROOT}")
DKSET(IOS_CXXFLAGS "-arch ${IOS_ARCH} -mios-simulator-version-min=${IOS_MIN_SDK_VERSION} -isysroot ${IOS_SYSROOT}")
DKSET(IOSSIM_SYSROOT ${XCODE_DEVROOT}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.0.sdk)
DKSET(IOSSIM_CFLAGS "-arch ${IOS_ARCH} -mios-simulator-version-min=${IOS_MIN_SDK_VERSION} -isysroot ${IOSSIM_SYSROOT}")
DKSET(IOSSIM_CXXFLAGS "-arch ${IOS_ARCH} -mios-simulator-version-min=${IOS_MIN_SDK_VERSION} -isysroot ${IOSSIM_SYSROOT}")
	
	DKSET(DKCONFIGURE_MAC64 ../../configure
	--disable-shared
	--enable-static)
	
	DKSET(DKCONFIGURE_IOS64 ../../configure
	--disable-shared
	--enable-static
	--host ${IOS_HOST}
	CC=${CLANG}
	CXX=${CLANGXX}
	CFLAGS=${IOS_CFLAGS}
	CXXFLAGS=${IOS_CXXFLAGS})
	
	DKSET(DKCONFIGURE_IOSSIM64 ../../configure
	--disable-shared
	--enable-static
	--host ${IOS_HOST}
	CC=${CLANG}
	CXX=${CLANGXX}
	CFLAGS=${IOSSIM_CFLAGS}
	CXXFLAGS=${IOSSIM_CXXFLAGS})
endif()


### LINUX ###
if(LINUX)
	##DKDEPEND(kdevelop)
	DKDEPEND(libx11-dev)
	LINUX_LIB(pthread)
	LINUX_LIB(dl)
	LINUX_LIB(libstdc++fs.a)
	
	# Linux Debug
	DKSET(DKCMAKE_LINUX_DEBUG ${CMAKE_EXE} -G "Unix Makefiles"
	-DCMAKE_BUILD_TYPE=Debug
	-DBUILD_SHARED_LIBS=OFF
	-DCMAKE_C_FLAGS=-fPIC)
	
	#Linux Release
	DKSET(DKCMAKE_LINUX_RELEASE ${CMAKE_EXE} -G "Unix Makefiles"
	-DCMAKE_BUILD_TYPE=Release
	-DBUILD_SHARED_LIBS=OFF
	-DCMAKE_C_FLAGS=-fPIC)
	
	# Linux 32 Debug
	DKSET(DKCMAKE_LINUX32_DEBUG ${CMAKE_EXE} -G "Unix Makefiles"
	-DCMAKE_BUILD_TYPE=Debug
	-DBUILD_SHARED_LIBS=OFF
	-DCMAKE_C_FLAGS=-fPIC)
	
	# Linux 32 Release
	DKSET(DKCMAKE_LINUX32_RELEASE ${CMAKE_EXE} -G "Unix Makefiles"
	-DCMAKE_BUILD_TYPE=Release
	-DBUILD_SHARED_LIBS=OFF
	-DCMAKE_C_FLAGS=-fPIC)
	
	# Linux 64 Debug
	DKSET(DKCMAKE_LINUX64_DEBUG ${CMAKE_EXE} -G "Unix Makefiles"
	-DCMAKE_BUILD_TYPE=Debug
	-DBUILD_SHARED_LIBS=OFF
	-DCMAKE_C_FLAGS=-fPIC)
	
	#Linux 64 Release
	DKSET(DKCMAKE_LINUX64_RELEASE ${CMAKE_EXE} -G "Unix Makefiles"
	-DCMAKE_BUILD_TYPE=Release
	-DBUILD_SHARED_LIBS=OFF
	-DCMAKE_C_FLAGS=-fPIC)
	
	DKSET(DKCONFIGURE_LINUX ../../configure 
	--disable-shared 
	--enable-static)
endif()


### RASPBERRY ###
if(CMAKE_HOST_LINUX AND RASPBERRY)
	DKDEPEND(libx11-dev)
	RASPBERRY_LIB(pthread)
	RASPBERRY_LIB(dl)
	RASPBERRY_LIB(libstdc++fs.a)
	link_directories(/opt/vc/lib)
	RASPBERRY_LIB(bcm_host)
	
	# Raspberry Debug
	DKSET(DKCMAKE_RASPBERRY_DEBUG ${CMAKE_EXE} -G "Unix Makefiles" 
	-DCMAKE_BUILD_TYPE=Debug 
	-DBUILD_SHARED_LIBS=OFF 
	-DCMAKE_C_FLAGS=-fPIC)
	
	# Raspberry Release
	DKSET(DKCMAKE_RASPBERRY_RELEASE ${CMAKE_EXE} -G "Unix Makefiles" 
	-DCMAKE_BUILD_TYPE=Release 
	-DBUILD_SHARED_LIBS=OFF 
	-DCMAKE_C_FLAGS=-fPIC)

	# Raspberry 32 Debug
	DKSET(DKCMAKE_RASPBERRY32_DEBUG ${CMAKE_EXE} -G "Unix Makefiles" 
	-DCMAKE_BUILD_TYPE=Debug 
	-DBUILD_SHARED_LIBS=OFF 
	-DCMAKE_C_FLAGS=-fPIC)
	
	# Raspberry 32 Release
	DKSET(DKCMAKE_RASPBERRY32_RELEASE ${CMAKE_EXE} -G "Unix Makefiles" 
	-DCMAKE_BUILD_TYPE=Release 
	-DBUILD_SHARED_LIBS=OFF 
	-DCMAKE_C_FLAGS=-fPIC)

	# Raspberry 64 Debug
	DKSET(DKCMAKE_RASPBERRY64_DEBUG ${CMAKE_EXE} -G "Unix Makefiles" 
	-DCMAKE_BUILD_TYPE=Debug 
	-DBUILD_SHARED_LIBS=OFF 
	-DCMAKE_C_FLAGS=-fPIC)
	
	# Raspberry 64 Release
	DKSET(DKCMAKE_RASPBERRY64_RELEASE ${CMAKE_EXE} -G "Unix Makefiles" 
	-DCMAKE_BUILD_TYPE=Release 
	-DBUILD_SHARED_LIBS=OFF 
	-DCMAKE_C_FLAGS=-fPIC)
	
	DKSET(DKCONFIGURE_RASPBERRY ../../configure 
	--disable-shared 
	--enable-static)
endif()


### ANDROID ###
if(CMAKE_HOST_WIN32 AND ANDROID)
	ANDROID_LIB(dl)
	ANDROID_LIB(log)
	ANDROID_LIB(android)
	DKDEPEND(jdk)
	DKDEPEND(apache-ant)
	DKDEPEND(android-sdk)
	#DKDEPEND(android-studio)
	DKDEPEND(android-ndk) 
	DKDEPEND(visualstudio)
	DKDEPEND(mingw32)
	DKDEPEND(msys)
	DKDEPEND(openssl)
	#DKINCLUDE(${ANDROIDNDK}/sources/android/cpufeatures)
	
	#Android arm32 with NDK toolchain
	DKSET(DKCMAKE_ANDROID32 ${CMAKE_EXE} -G ${VISUALSTUDIO_NAME} -A ARM
	-DANDROID_NDK=${ANDROIDNDK}
	-DCMAKE_TOOLCHAIN_FILE=${ANDROIDNDK}/build/cmake/android.toolchain.cmake
	-DANDROID_TOOLCHAIN=clang
	-DANDROID_ABI=armeabi-v7a
	-DANDROID_PLATFORM=android-26
	-DANDROID_STL_FORCE_FEATURES=TRUE
	-DANDROID_NO_UNDEFINED=TRUE
	-DANDROID_STL=c++_static)
		
	#Android arm64 with NDK toolchain
	DKSET(DKCMAKE_ANDROID64 ${CMAKE_EXE} -G ${VISUALSTUDIO_NAME} -A ARM64
	-DANDROID_NDK=${ANDROIDNDK}
	-DCMAKE_TOOLCHAIN_FILE=${ANDROIDNDK}/build/cmake/android.toolchain.cmake
	-DANDROID_TOOLCHAIN=clang
	-DANDROID_ABI=arm64-v8a
	-DANDROID_PLATFORM=android-26
	-DANDROID_STL_FORCE_FEATURES=TRUE
	-DANDROID_NO_UNDEFINED=TRUE
	-DANDROID_STL=c++_static)
	
	DKSET(DKCONFIGURE_ANDROID ../../configure 
	--disable-shared 
	--enable-static)
	
	# https://developer.android.com/ndk/guides/cmake
	# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-android
	#DKSET(DKCMAKE_ANDROID32_CPUFEATURES ${CMAKE_EXE} -G ${VISUALSTUDIO_NAME} -A ARM 
	#"-DCMAKE_ANDROID_NDK=${ANDROIDNDK}"
	#"-DCMAKE_TOOLCHAIN_FILE=${ANDROIDNDK}/build/cmake/android.toolchain.cmake"
	#"-DANDROID_PLATFORM=android-26"
	#"-DANDROID_ABI=armeabi-v7a with NEON" 
	#"-DANDROID_ARM_NEON=TRUE"
	#"-DCMAKE_ANDROID_STL=c++_static"
	#"-DANDROID_CPP_FEATURES=rtti exceptions" 
	#"-DBUILD_SHARED_LIBS=OFF"
	#"-DCMAKE_C_FLAGS=-DANDROID -D_ANDROID32" 
	#"-DCMAKE_C_FLAGS_DEBUG=-g2 -gdwarf-2 -O0 -DDEBUG -D_DEBUG" 
	#"-DCMAKE_C_FLAGS_RELEASE=-DNDEBUG" 
	#"-DCMAKE_CXX_FLAGS=-DANDROID -D_ANDROID32" 
	#"-DCMAKE_CXX_FLAGS_DEBUG=-g2 -gdwarf-2 -O0 -DDEBUG -D_DEBUG" 
	#"-DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG")
endif()
