message("#######################################################################")
message("#################### linux_x86_gcc_toolchain.cmake ####################")
message("#######################################################################")

#dk_depend(build-essential)
dk_depend(gcc)
dk_depend(make)

dk_findProgram(CMAKE_MAKE_PROGRAM 	make)
dk_set(CMAKE_GENERATOR 				"Unix Makefiles")

#dk_set(USR_BIN						"/usr/bin")
#dk_set(USR_LOCAL_BIN				"/usr/local/bin")

###### CMAKE_C_COMPILER ######
if(EXISTS /usr/bin/clang)
	dk_set(CMAKE_C_COMPILER			/usr/bin/clang)
elseif(EXISTS /usr/local/bin/clang)
	dk_set(CMAKE_C_COMPILER			/usr/local/bin/clang)
endif()

###### CMAKE_CXX_COMPILER ######
if(EXISTS /usr/bin/clang++)
	dk_set(CMAKE_CXX_COMPILER		/usr/bin/clang++)
elseif(EXISTS /usr/local/bin/clang++)
	dk_set(CMAKE_CXX_COMPILER		/usr/local/bin/clang++)
endif()


#dk_set(CMAKE_RC_COMPILER			${CLANG_RC_COMPILER})
dk_append(CMAKE_C_FLAGS				-march=i686 -DLINUX -DLINUX_X86 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)