if not defined Linux_Host (
	set "CMAKE_GENERATOR="
	exit /b 0
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "####################### Linux_X86_Clang_Toolchain.cmd ######################"
%dk_call% dk_echo "############################################################################"

set CMAKE_GENERATOR="Unix Makefiles"





rem %dk_call% dk_depend build-essential)
::%dk_call% dk_depend gcc)
::%dk_call% dk_depend make
::dk_findProgram(CMAKE_MAKE_PROGRAM 	make
::%dk_call% dk_set CMAKE_GENERATOR 				"Unix Makefiles"
rem %dk_call% dk_set USR_BIN						"/usr/bin"
rem %dk_call% dk_set USR_LOCAL_BIN				"/usr/local/bin"
::###### CMAKE_C_COMPILER ######
::if(EXISTS /usr/bin/clang
::	%dk_call% dk_set CMAKE_C_COMPILER			/usr/bin/clang
::elseif(EXISTS /usr/local/bin/clang
::	%dk_call% dk_set CMAKE_C_COMPILER			/usr/local/bin/clang
::)
::###### CMAKE_CXX_COMPILER ######
::if(EXISTS /usr/bin/clang++)
::	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/bin/clang++)
::elseif(EXISTS /usr/local/bin/clang++)
::	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/local/bin/clang++)
::)
rem %dk_call% dk_set CMAKE_RC_COMPILER			%CLANG_RC_COMPILER%
rem  %dk_call% dk_append CMAKE_C_FLAGS				-march=i686 -DLINUX -DLINUX_X86 -std=gnu11
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-march=i686 -DLINUX -DLINUX_X86 -std=gnu++17 -lstdc++fs)
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS	-static  &rem  -s)
