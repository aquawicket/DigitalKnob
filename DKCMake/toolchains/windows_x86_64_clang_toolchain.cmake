message("windoows_x86_64_clang_toolchain.cmake")


dk_echo("######################################################################")
dk_echo("################ windoows_x86_64_clang_toolchain.cmake ###############")
dk_echo("######################################################################")


dk_depend(msys2)
dk_set(msystem 			clang64)
dk_set(MSYSTEM 			CLANG64)
dk_depend(clang)

### Set CMAKE_GENERATOR ###
#dk_depend(cmd)
if(CMD_EXE OR MINGW)
	dk_set(MSYS2_GENERATOR	"MinGW Makefiles")	# if in CMD shell
else()
	dk_set(MSYS2_GENERATOR 	"MSYS Makefiles")	# if in SH shell
endif()
if((NOT CMAKE_GENERATOR) AND (MSYS2_GENERATOR))
	dk_set(CMAKE_GENERATOR ${MSYS2_GENERATOR})
endif()

set(CLANG64_DIR 		${MSYS2_DIR}/clang64)
set(CMAKE_MAKE_PROGRAM 	${CLANG64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER	${CLANG64_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER 	${CLANG64_DIR}/bin/clang++.exe)

dk_append(DKFLAGS 					-DMSYSTEM=CLANG64)
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DMSYSTEM=CLANG64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17) # -D_WIN32_WINNT=0x0600
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DMSYSTEM=CLANG64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17) # -D_WIN32_WINNT=0x0600
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
dk_append(DKCONFIGURE_FLAGS			--build=x86_64-w64-mingw32)
dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})
