message("############################################################################")
message("################### ios_x86_64_clang_toolchain.cmake #######################")
message("############################################################################")

if(NOT Mac_Host)
	dk_exit()
endif()

dk_depend(xcode)
dk_depend(make)
	
dk_set(CMAKE_TOOLCHAIN_FILE			${IOS_TOOLCHAIN_FILE})
dk_append(CMAKE_C_FLAGS				-DIOS -DIOS_X86_64 -std=c17 -x objective-c)
dk_append(CMAKE_CXX_FLAGS			-DIOS -DIOS_X86_64 -std=c++17 -x objective-c++)
dk_append(DKCONFIGURE_FLAGS			--host x86_64-apple-${IOS_DARWIN})
dk_append(DKCONFIGURE_CFLAGS		-arch x86_64 -DIOS -DIOS_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSS_SYSROOT})
dk_append(DKCONFIGURE_CXXFLAGS		-arch x86_64 -DIOS -DIOS_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSS_SYSROOT})
dk_append(DKCMAKE_FLAGS				-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=x86_64)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
	