message("############################################################################")
message("#################### Iossim_X86_Clang_Toolchain.cmake ######################")
message("############################################################################")

if(NOT Mac_Host)
	dk_exit()
endif()

dk_depend(xcode)
dk_depend(make)
	
dk_set(CMAKE_TOOLCHAIN_FILE			${IOS_TOOLCHAIN_FILE})
dk_append(CMAKE_C_FLAGS				-DIOS -DIOSSIM -DIOSSIM_X86 -std=c17 -x objective-c)
dk_append(CMAKE_CXX_FLAGS			-DIOS -DIOSSIM -DIOSSIM_X86 -std=c++17 -x objective-c++)
dk_append(DKCONFIGURE_FLAGS			--host i686-apple-${IOS_DARWIN})
dk_append(DKCONFIGURE_CFLAGS		-arch i686 -DIOS -DIOSSIM -DIOSSIM_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
dk_append(DKCONFIGURE_CXXFLAGS		-arch i686 -DIOS -DIOSSIM -DIOSSIM_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT})
dk_append(DKCMAKE_FLAGS				-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=SIMULATOR -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=i686)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
	