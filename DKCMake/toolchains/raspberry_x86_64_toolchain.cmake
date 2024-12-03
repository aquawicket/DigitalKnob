message("#######################################################################")
message("################# raspbery_x86_84_toolchain.cmake #####################")
message("#######################################################################")

#dk_depend(build-essential)
dk_depend(gcc)
dk_depend(make)
	
dk_append(CMAKE_C_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_X86_64 -std=gnu11) 					#-march=armv7l
dk_append(CMAKE_CXX_FLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_X86_64 -std=gnu++17 -lstdc++fs) 	#-march=armv7l 
dk_append(DKCONFIGURE_CFLAGS		-DLINUX -DRASPBERRY -DRASPBERRY_X86_64 -std=gnu11) 					#-march=armv7l 
dk_append(DKCONFIGURE_CXXFLAGS		-DLINUX -DRASPBERRY -DRASPBERRY_X86_64 -std=gnu++17 -lstdc++fs) 	#-march=armv7l
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
