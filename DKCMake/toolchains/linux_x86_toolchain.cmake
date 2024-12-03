message("#######################################################################")
message("#################### linux_x86_toolchain.cmake ########################")
message("#######################################################################")

#dk_depend(build-essential)
dk_depend(gcc)
dk_depend(make)
	
dk_append(CMAKE_C_FLAGS				-march=i686 -DLINUX -DLINUX_X86 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs)
dk_append(DKCONFIGURE_CFLAGS		-march=i686 -DLINUX -DLINUX_X86 -std=gnu11)
dk_append(DKCONFIGURE_CXXFLAGS		-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
