if(NOT ANDROID)
	dk_undepend(log)
	dk_return()
endif()

dk_depend(android-ndk)


dk_findLibrary(log)
#dk_include(${ANDROID-NDK}/toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/include)
#SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -llog")
