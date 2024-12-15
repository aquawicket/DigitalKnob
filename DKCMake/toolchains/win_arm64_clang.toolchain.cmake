message("######################################################################")
message("################ windoows_arm64_clang_toolchain.cmake ################")
message("######################################################################")

############ CMAKE COMPILER VARIABLES ############
dk_depend(msys2)
dk_depend(clang)

dk_set(MSYSTEM 						CLANGARM64)

dk_prependEnvPath("${CLANGARM64_BIN}")

dk_set(CMAKE_GENERATOR				"MinGW Makefiles")
dk_set(CMAKE_MAKE_PROGRAM 			"${CLANGARM64_BIN}/mingw32-make.exe")
dk_set(CMAKE_C_COMPILER				"${CLANGARM64_BIN}/clang.exe")
dk_set(CMAKE_CXX_COMPILER 			"${CLANGARM64_BIN}/clang++.exe")
dk_set(CMAKE_RC_COMPILER  			"${CLANGARM64_BIN}/windres.exe")

dk_append(CMAKE_C_FLAGS				-march=aarch64 -DMSYSTEM=${MSYSTEM} -DWIN -DWIN_ARM64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
dk_append(CMAKE_CXX_FLAGS			-march=aarch64 -DMSYSTEM=${MSYSTEM} -DWIN -DWIN_ARM64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)

#dk_set(DKCONFIGURE_CC				${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX				${CMAKE_CXX_COMPILER})
dk_append(DKCONFIGURE_FLAGS			--build=aarch64-w64-mingw32)
#dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})
