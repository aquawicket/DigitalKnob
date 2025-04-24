message("############################################################################")
message("################## raspbery_arm64_clang_toolchain.cmake ####################")
message("############################################################################")

if(NOT RASPBERRY_HOST)
	dk_exit()
endif()

#dk_depend(build-essential)
dk_depend(clang)
dk_depend(make)
	
dk_append(CMAKE_C_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu11) 				#-march=armv7l
dk_append(CMAKE_CXX_FLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu++17 -lstdc++fs) 	#-march=armv7l 
#dk_append(DKCONFIGURE_CFLAGS		-DLINUX -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu11) 				#-march=armv7l 
#dk_append(DKCONFIGURE_CXXFLAGS		-DLINUX -DRASPBERRY -DRASPBERRY_ARM64 -std=gnu++17 -lstdc++fs) 	#-march=armv7l
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
