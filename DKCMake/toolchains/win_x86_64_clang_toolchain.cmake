message("######################################################################")
message("################ windoows_x86_64_clang_toolchain.cmake ###############")
message("######################################################################")

############ CMAKE COMPILER VARIABLES ############
dk_depend(msys2)
dk_depend(clang)

dk_set(msystem 						clang64)
dk_set(MSYSTEM 						CLANG64)

dk_set(CMAKE_GENERATOR				"MinGW Makefiles")
dk_set(CMAKE_MAKE_PROGRAM 			"${MSYS2_DIR}/clang64/bin/mingw32-make.exe")
dk_set(CMAKE_C_COMPILER				"${MSYS2_DIR}/clang64/bin/clang.exe")
dk_set(CMAKE_CXX_COMPILER 			"${MSYS2_DIR}/clang64/bin/clang++.exe")
dk_set(CMAKE_RC_COMPILER  			"${MSYS2_DIR}/clang64/bin/windres.exe")

dk_append(DKFLAGS 					-DMSYSTEM=CLANG64)
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DMSYSTEM=CLANG64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DMSYSTEM=CLANG64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)

dk_set(DKCONFIGURE_CC				${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX				${CMAKE_CXX_COMPILER})
dk_append(DKCONFIGURE_FLAGS			--build=x86_64-w64-mingw32)
dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})

############ Bash Variable Exports ############
#dk_depend(cygpath)
#dk_command(${CYGPATH_EXE} -m 		"${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_UNIXPATH)
#dk_set(MSYS2_BIN					"export PATH=${MSYS2_UNIXPATH}/usr/bin:$PATH")
#dk_set(MSYS2_EXE 					"${MSYS2_DIR}/msys2.exe")
#dk_set(CLANG64_BIN					"export PATH=${MSYS2_UNIXPATH}/clang64/bin:$PATH")
#dk_set(CLANG64_EXE 				"${MSYS2_DIR}/clang64.exe")

