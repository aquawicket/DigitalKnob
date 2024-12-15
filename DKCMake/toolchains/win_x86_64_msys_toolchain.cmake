message("######################################################################")
message("################ windows_x86_64_msys_toolchain.cmake #################")
message("######################################################################")

############ CMAKE COMPILER VARIABLES ############
dk_depend(msys2)
dk_set(msystem 						msys)
dk_set(MSYSTEM 						MSYS)

dk_depend(gcc)

#dk_depend(cmd)
#if(CMD_EXE OR MINGW)
	set(CMAKE_GENERATOR				"MinGW Makefiles")	# if in CMD shell
#else()
#	set(CMAKE_GENERATOR 			"MSYS Makefiles")	# if in SH shell
#endif()

dk_set(CMAKE_MAKE_PROGRAM 			"${MSYS2_DIR}/usr/bin/mingw32-make.exe")
dk_set(CMAKE_C_COMPILER				"${MSYS2_DIR}/usr/bin/gcc.exe")
dk_set(CMAKE_CXX_COMPILER 			"${MSYS2_DIR}/usr/bin/g++.exe")
dk_set(CMAKE_RC_COMPILER  			"${MSYS2_DIR}/usr/bin/windres.exe")

dk_append(DKFLAGS 					-DMSYSTEM=MSYS)
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DMSYSTEM=MSYS -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DMSYSTEM=MSYS -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
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
