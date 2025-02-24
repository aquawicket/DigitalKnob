message("############################################################################")
message("###################### linux_arm63_gcc_toolchain.cmake #####################")
message("############################################################################")

#dk_depend(build-essential)
dk_depend(gcc)
dk_depend(make)

dk_findProgram(CMAKE_MAKE_PROGRAM 	make)
dk_set(CMAKE_GENERATOR 				"Unix Makefiles")

#dk_set(USR_BIN						"/usr/bin")
#dk_set(USR_LOCAL_BIN				"/usr/local/bin")

###### CMAKE_C_COMPILER ######
if(EXISTS /usr/bin/gcc)
	dk_set(CMAKE_C_COMPILER			/usr/bin/gcc)
elseif(EXISTS /usr/local/bin/gcc)
	dk_set(CMAKE_C_COMPILER			/usr/local/bin/gcc)
endif()

###### CMAKE_CXX_COMPILER ######
if(EXISTS /usr/bin/g++)
	dk_set(CMAKE_CXX_COMPILER		/usr/bin/g++)
elseif(EXISTS /usr/local/bin/g++)
	dk_set(CMAKE_CXX_COMPILER		/usr/local/bin/g++)
endif()

#dk_set(CMAKE_RC_COMPILER			${GCC_RC_COMPILER})
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)