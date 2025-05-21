if not defined Linux_Host (
	exit /b 1
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "#################### Linux_Arm32_Clang_Toolchain.cmd #######################"
%dk_call% dk_echo "############################################################################"

set CMAKE_GENERATOR="Unix Makefiles"





rem %dk_call% dk_depend 	build-essential
::%dk_call% dk_depend 		clang
::%dk_call% dk_depend 		make
::%dk_call% dk_findProgram 	CMAKE_MAKE_PROGRAM 			"make"
::%dk_call% dk_set 			CMAKE_GENERATOR 			"Unix Makefiles"
rem %dk_call% dk_set 		USR_BIN						"/usr/bin"
rem %dk_call% dk_set 		USR_LOCAL_BIN				"/usr/local/bin"
rem ###### CMAKE_C_COMPILER ######
::if exist "/usr/bin/clang"
::	%dk_call% dk_set 		CMAKE_C_COMPILER			"/usr/bin/clang"
::) else if exist "/usr/local/bin/clang" (
::	%dk_call% dk_set 		CMAKE_C_COMPILER			"/usr/local/bin/clang"
::)
rem ###### CMAKE_CXX_COMPILER ######
::if exist "/usr/bin/clang++" (
::	%dk_call% dk_set 		CMAKE_CXX_COMPILER			"/usr/bin/clang++"
::) else if exist "/usr/local/bin/clang++" (
::	%dk_call% dk_set 		CMAKE_CXX_COMPILER			"/usr/local/bin/clang++"
::)
rem %dk_call% dk_set 		CMAKE_RC_COMPILER			"%CLANG_RC_COMPILER%"
rem %dk_call% dk_append 	CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_ARM -std=gnu11
rem %dk_call% dk_append 	CMAKE_CXX_FLAGS				-march=x86-64 -DLINUX -DLINUX_ARM -std=gnu++17 -lstdc++fs)
rem %dk_call% dk_append 	CMAKE_EXE_LINKER_FLAGS		"-static"  &rem  -s)