message("#######################################################################")
message("#################### linux_x86_64_gcc_toolchain.cmake #####################")
message("#######################################################################")

#dk_depend(build-essential)
dk_depend(gcc)
dk_depend(make)
	
dk_findProgram(CMAKE_MAKE_PROGRAM 	make)
dk_set(CMAKE_GENERATOR 				"Unix Makefiles")


if(EXISTS /usr/bin/gcc)
	dk_set(GCC_C_COMPILER	/usr/bin/gcc)
elseif(EXISTS /usr/local/bin/gcc)
	dk_set(GCC_C_COMPILER	/usr/local/bin/gcc)
endif()
if(EXISTS /usr/bin/g++)
	dk_set(GCC_CXX_COMPILER	/usr/bin/g++)
elseif(EXISTS /usr/local/bin/g++)
	dk_set(GCC_CXX_COMPILER	/usr/local/bin/g++)
endif()
dk_set(CMAKE_C_COMPILER				${GCC_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER			${GCC_CXX_COMPILER})

dk_set(CMAKE_RC_COMPILER			${GCC_RC_COMPILER})
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
	