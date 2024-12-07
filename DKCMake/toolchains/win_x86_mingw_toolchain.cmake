message("######################################################################")
message("################ windoows_x86_mingw_toolchain.cmake ###############")
message("######################################################################")

############ CMAKE COMPILER VARIABLES ############
dk_depend(msys2)
dk_set(msystem 						mingw32)
dk_set(MSYSTEM 						MINGW32)

dk_depend(gcc)

dk_depend(cmd)
if(CMD_EXE OR MINGW)
	set(CMAKE_GENERATOR				"MinGW Makefiles")	# if in CMD shell
else()
	set(CMAKE_GENERATOR 			"MSYS Makefiles")	# if in SH shell
endif()
set(CMAKE_MAKE_PROGRAM 				${MSYS2_DIR}/mingw32/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER				${MSYS2_DIR}/mingw32/bin/gcc.exe)
set(CMAKE_CXX_COMPILER 				${MSYS2_DIR}/mingw32/bin/g++.exe)
dk_append(DKFLAGS 					-DMSYSTEM=MINGW32)
dk_append(CMAKE_C_FLAGS				-march=i686 -DMSYSTEM=MINGW32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17) # -D_WIN32_WINNT=0x0600
dk_append(CMAKE_CXX_FLAGS			-march=i686 -DMSYSTEM=MINGW32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17) # -D_WIN32_WINNT=0x0600
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
dk_append(DKCONFIGURE_FLAGS			--build=i686-w64-mingw32)
dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})

############ Bash Variable Exports ############
dk_depend(cygpath)
dk_command(${CYGPATH_EXE} -m 	"${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_UNIXPATH)
dk_set(MSYS2_BIN				"export PATH=${MSYS2_UNIXPATH}/usr/bin:$PATH")
dk_set(MSYS2_EXE 				"${MSYS2_DIR}/msys2.exe")
dk_set(MINGW32_BIN				"export PATH=${MSYS2_UNIXPATH}/mingw32/bin:$PATH")
dk_set(MINGW32_EXE 				"${MSYS2_DIR}/mingw32.exe")