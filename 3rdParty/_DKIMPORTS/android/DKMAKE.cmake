if(NOT ANDROID)
	dk_undepend(android)
	dk_return()
endif()

dk_depend(android-ndk)

#dk_include(${ANDROID-NDK}/toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/include)
#dk_findLibrary(android)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -landroid")
