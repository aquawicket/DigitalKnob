message(STATUS "##############################################################")
message(STATUS "################ android_arm32_toolchain.cmake ###############")
message(STATUS "##############################################################")

dk_depend(android-ndk)
set(CMAKE_TOOLCHAIN_FILE			"${ANDROID_TOOLCHAIN_FILE}")
set(CMAKE_GENERATOR					"Unix Makefiles")
set(ANDROID_PLATFORM				31)
set(CMAKE_MAKE_PROGRAM				"${ANDROID_MAKE_PROGRAM}")
set(CMAKE_C_COMPILER				"${ANDROID_C_COMPILER}")
set(CMAKE_CXX_COMPILER				"${ANDROID_CXX_COMPILER}")
dk_append(CMAKE_C_FLAGS				-DANDROID -DANDROID_ARM32 -std=c17)
dk_append(CMAKE_CXX_FLAGS			-DANDROID -DANDROID_ARM32 -std=c++1z)
dk_set(DKCONFIGURE_CC				"${ANDROID_C_COMPILER}")
dk_set(DKCONFIGURE_CXX				"${ANDROID_CXX_COMPILER}")
dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})
	
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
