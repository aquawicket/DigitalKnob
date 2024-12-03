message("######################################################################")
message("#################### linux_arm63_toolchain.cmake #####################")
message("######################################################################")

#dk_depend(build-essential)
dk_depend(gcc)
dk_depend(make)
	
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu++17 -lstdc++fs)
dk_append(DKCONFIGURE_CFLAGS		-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu11)
dk_append(DKCONFIGURE_CXXFLAGS		-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)