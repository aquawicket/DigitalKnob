message("############################################################################")
message("###################### mac_arm64_clang_toolchain.cmake #####################")
message("############################################################################")

if(NOT MAC_HOST)
	dk_exit()
endif()

dk_depend(xcode)
dk_depend(make)
	
dk_append(CMAKE_C_FLAGS				-DMAC -DMAC_ARM64 -std=c17 -x objective-c)
dk_append(CMAKE_CXX_FLAGS			-DMAC -DMAC_ARM64 -std=c++17 -x objective-c++)
dk_append(DKCONFIGURE_CFLAGS		-DMAC -DMAC_ARM64 -std=c17) #-x objective-c) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
dk_append(DKCONFIGURE_CXXFLAGS		-DMAC -DMAC_ARM64 -std=c++17) #-x objective-c++) #https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
dk_append(DKCMAKE_FLAGS				-DCMAKE_OSX_ARCHITECTURES=ARM64)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
