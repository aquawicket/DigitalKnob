message(STATUS "####################################################################")
message(STATUS "################ android_arm32_toolchain.cmake #####################")
message(STATUS "####################################################################")

dk_validate(ANDROID_TOOLCHAIN_FILE		"dk_depend(android-ndk)")
set(CMAKE_TOOLCHAIN_FILE				"${ANDROID_TOOLCHAIN_FILE}")

set(CMAKE_GENERATOR						"Unix Makefiles")
set(ANDROID_PLATFORM					31)

if(WIN_HOST)
	dk_validate(MSYS2_MAKE_PROGRAM		"dk_depend(msys2)")
	dk_set(CMAKE_MAKE_PROGRAM			"${MSYS2_MAKE_PROGRAM}")
else()
	dk_set(CMAKE_MAKE_PROGRAM			"make")
endif()

set(CMAKE_C_COMPILER					"${ANDROID_C_COMPILER}")
set(CMAKE_CXX_COMPILER					"${ANDROID_CXX_COMPILER}")
dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_ARM32 -std=c17)
dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM32 -std=c++1z)

#dk_set(DKCONFIGURE_CC					${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX					${CMAKE_CXX_COMPILER})
#dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
	
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


#dk_depend(android-ndk)
#set(ANDROID_ABI					armeabi-v7a)
#set(ANDROID_API					31)
#set(ANDROID_PLATFORM				31)
#set(ANDROID_NATIVE_API_LEVEL		31)
#
#set(ANDROID_CPP_FEATURES			"rtti exceptions")
#set(ANDROID_STL					c++_static)
#set(ANDROID_STL_FORCE_FEATURES		1)
#set(ANDROID_TOOLCHAIN				clang)
#set(CMAKE_ANDROID_STL_TYPE			c++_static)
#
#dk_set(CMAKE_GENERATOR				"Unix Makefiles")
#dk_set(CMAKE_TOOLCHAIN_FILE		"${ANDROID_NDK}/build/cmake/android.toolchain.cmake")
#dk_set(CMAKE_MAKE_PROGRAM			"${ANDROID_NDK}/prebuilt/${ANDROID_HOST_TAG}/bin/make${exe}")
#
#if(ANDROID_HOST)
#	dk_set(CMAKE_MAKE_PROGRAM		"make")
#else()
#	dk_validate(MSYS2_MAKE_PROGRAM	"dk_depend(msys2)")
#	dk_set(CMAKE_MAKE_PROGRAM		"${MSYS2_MAKE_PROGRAM}")
#endif()
#
#dk_set(CMAKE_C_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang${exe}")
#dk_set(CMAKE_CXX_COMPILER			"${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang++${exe}")
#dk_append(CMAKE_C_FLAGS			-DANDROID -DANDROID_ARM32 -std=c17)
#dk_append(CMAKE_CXX_FLAGS			-DANDROID -DANDROID_ARM32 -std=c++1z)
#
#dk_set(DKCONFIGURE_CC				"${CMAKE_C_COMPILER}")
#dk_set(DKCONFIGURE_CXX				"${CMAKE_CXX_COMPILER}")
#dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})
#	
#dk_append(DKCMAKE_FLAGS
#	-DANDROID_ABI=${ANDROID_ABI}
#	-DANDROID_CPP_FEATURES=${ANDROID_CPP_FEATURES}
#	-DANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL}
#	-DANDROID_NDK=${ANDROID_NDK}
#	-DANDROID_PLATFORM=${ANDROID_PLATFORM}
#	-DANDROID_STL=${ANDROID_STL}
#	-DANDROID_STL_FORCE_FEATURES=${ANDROID_STL_FORCE_FEATURES}
#	-DANDROID_TOOLCHAIN=${ANDROID_TOOLCHAIN}
#	-DCMAKE_ANDROID_STL_TYPE=${CMAKE_ANDROID_STL_TYPE}
#)
