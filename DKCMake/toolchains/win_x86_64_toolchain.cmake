message("######################################################################")
message("################ windoows_x86_64_toolchain.cmake #####################")
message("######################################################################")

dk_validate(MSYS2 "dk_depend(msys2)")
dk_depend(clang)

dk_set(MSYSTEM 						CLANG64)
dk_prependEnvPath(					"${MSYS2}/usr/bin")
dk_prependEnvPath(					"${${MSYSTEM}_BIN}")
set(ENV{ACLOCAL_PATH} 				"${MSYS2_DIR}/usr/share/aclocal")

dk_set(CMAKE_GENERATOR				"MinGW Makefiles")
dk_set(CMAKE_MAKE_PROGRAM 			"${${MSYSTEM}_BIN}/mingw32-make.exe")
dk_set(CMAKE_C_COMPILER				"${${MSYSTEM}_BIN}/clang.exe")
dk_set(CMAKE_CXX_COMPILER 			"${${MSYSTEM}_BIN}/clang++.exe")
dk_set(CMAKE_RC_COMPILER  			"${${MSYSTEM}_BIN}/windres.exe")

dk_append(CMAKE_C_FLAGS				-march=x86-64 -DMSYSTEM=${MSYSTEM} -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DMSYSTEM=${MSYSTEM} -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -mconsole -s)

dk_append(DKCONFIGURE_FLAGS			--build=x86_64-w64-mingw32)
