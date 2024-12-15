message("######################################################################")
message("################ windoows_x86_64_mingw_toolchain.cmake ###############")
message("######################################################################")

############ CMAKE COMPILER VARIABLES ############
dk_depend(msys2)
dk_depend(gcc)

dk_set(msystem 						mingw64)
dk_set(MSYSTEM 						MINGW64)

dk_prependEnvPath("${MSYS2}/mingw64/bin")

dk_set(CMAKE_GENERATOR				"MinGW Makefiles")
dk_set(CMAKE_MAKE_PROGRAM 			"${MSYS2_DIR}/mingw64/bin/mingw32-make.exe")
dk_set(CMAKE_C_COMPILER				"${MSYS2_DIR}/mingw64/bin/gcc.exe")
dk_set(CMAKE_CXX_COMPILER 			"${MSYS2_DIR}/mingw64/bin/g++.exe")
dk_set(CMAKE_RC_COMPILER  			"${MSYS2_DIR}/mingw64/bin/windres.exe")

dk_append(DKFLAGS 					-DMSYSTEM=MINGW64)
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)

dk_set(DKCONFIGURE_CC				${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX				${CMAKE_CXX_COMPILER})
dk_append(DKCONFIGURE_FLAGS			--build=x86_64-w64-mingw32)
dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})
