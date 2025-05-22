::### FIXME ###
exit /b 1

if not defined Windows_Host (
	exit /b 1
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################### Windows_Arm64_Clang_Toolchain.cmd ######################"
%dk_call% dk_echo "############################################################################"

(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANGARM64)
set CMAKE_GENERATOR="MinGW Makefiles"




::%dk_call% dk_validate 			MSYS2 						"%dk_call% dk_depend msys2"
::%dk_call% dk_depend 			clang
::%dk_call% dk_set 				MSYSTEM 					CLANGARM64
::%dk_call% dk_prependEnvPath 	"!%MSYSTEM%_BIN!"
::%dk_call% dk_set 				CMAKE_GENERATOR				"MinGW Makefiles"
::%dk_call% dk_set 				CMAKE_MAKE_PROGRAM 			"!%MSYSTEM%_BIN!/mingw32-make.exe"
::%dk_call% dk_set 				CMAKE_C_COMPILER			"!%MSYSTEM%_BIN!/clang.exe"
::%dk_call% dk_set 				CMAKE_CXX_COMPILER 			"!%MSYSTEM%_BIN!/clang++.exe"
::%dk_call% dk_set 				CMAKE_RC_COMPILER  			"!%MSYSTEM%_BIN!/windres.exe"
rem  %dk_call% dk_append 		CMAKE_C_FLAGS				-march=aarch64 -DMSYSTEM=%MSYSTEM% -DWIN -DWIN_ARM64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17
rem  %dk_call% dk_append 		CMAKE_CXX_FLAGS				-march=aarch64 -DMSYSTEM=%MSYSTEM% -DWIN -DWIN_ARM64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17
rem  %dk_call% dk_append 		CMAKE_EXE_LINKER_FLAGS		-static  &rem  -s
rem  %dk_call% dk_append 		DKCONFIGURE_FLAGS			--build=aarch64-w64-mingw32
