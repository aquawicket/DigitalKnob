message("#############################################################################")
message("#################### linux_x86_64_clang_toolchain.cmake #####################")
message("#############################################################################")

#dk_depend(build-essential)
dk_depend(clang)
dk_depend(make)
	
dk_findProgram(CMAKE_MAKE_PROGRAM 	make)
dk_set(CMAKE_GENERATOR 				"Unix Makefiles")
dk_set(CMAKE_C_COMPILER				${CLANG_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER			${CLANG_CXX_COMPILER})
dk_set(CMAKE_RC_COMPILER			${CLANG_RC_COMPILER})
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
#dk_append(DKCONFIGURE_CFLAGS		-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11)
#dk_append(DKCONFIGURE_CXXFLAGS		-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
	