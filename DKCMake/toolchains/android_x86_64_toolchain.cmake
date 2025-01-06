dk_echo(STATUS "##############################################################")
dk_echo(STATUS "################ android_x86_64_toolchain.cmake ###############")
dk_echo(STATUS "##############################################################")

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
dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_X86_64 -std=c17)
dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_X86_64 -std=c++1z)

#dk_set(DKCONFIGURE_CC					${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX					${CMAKE_CXX_COMPILER})
#dk_append(DKCONFIGURE_CFLAGS			${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS			${CMAKE_CXX_FLAGS})
	
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