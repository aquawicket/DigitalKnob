message(STATUS "####################################################################")
message(STATUS "################ android_arm64_clang_toolchain.cmake ###############")
message(STATUS "####################################################################")

dk_validate(ANDROID_TOOLCHAIN_FILE		"dk_depend(android-ndk)")
dk_set(ANDROID_ABI						arm64-v8a)
dk_set(ANDROID_CPP_FEATURES				"rtti exceptions")
dk_set(ANDROID_NATIVE_API_LEVEL			${ANDROID_API})
dk_set(ANDROID_NDK						${ANDROID_NDK})
dk_set(ANDROID_PLATFORM					${ANDROID_API})
dk_set(ANDROID_STL						c++_static)
dk_set(ANDROID_STL_FORCE_FEATURES		1)
dk_set(ANDROID_TOOLCHAIN				clang)
dk_set(CMAKE_ANDROID_STL_TYPE			c++_static)

set(CMAKE_TOOLCHAIN_FILE				"${ANDROID_TOOLCHAIN_FILE}")

set(CMAKE_GENERATOR						"Unix Makefiles")
set(ANDROID_PLATFORM					31)

if(WIN_HOST)
	dk_validate(MSYS2_MAKE_PROGRAM		"dk_depend(msys2)")
	dk_set(CMAKE_MAKE_PROGRAM			"${MSYS2_MAKE_PROGRAM}")
else()
	dk_set(CMAKE_MAKE_PROGRAM			"make")
endif()

dk_set(CMAKE_C_COMPILER					"${ANDROID_C_COMPILER}")
dk_set(CMAKE_CXX_COMPILER				"${ANDROID_CXX_COMPILER}")
dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_ARM64 -std=c17)
dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM64 -std=c++1z)

#dk_set(DKCONFIGURE_CC					${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX					${CMAKE_CXX_COMPILER})
#dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
	
dk_append(DKCMAKE_FLAGS
	             -DANDROID_ABI=${ANDROID_ABI}
	   "-DANDROID_CPP_FEATURES=${ANDROID_CPP_FEATURES}"
	-DANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL}
	             -DANDROID_NDK=${ANDROID_NDK}
	        -DANDROID_PLATFORM=${ANDROID_PLATFORM}
	             -DANDROID_STL=${ANDROID_STL}
  -DANDROID_STL_FORCE_FEATURES=${ANDROID_STL_FORCE_FEATURES}
           -DANDROID_TOOLCHAIN=${ANDROID_TOOLCHAIN}
	  -DCMAKE_ANDROID_STL_TYPE=${DCMAKE_ANDROID_STL_TYPE}
)