if NOT defined Linux_Host (
	exit /b 1
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "###################### Linux_Arm64_Gcc_toolchain.cmd #######################"
%dk_call% dk_echo "############################################################################"

%dk_call% DKIMPORTS_DIR			%dk_call% dk_DKIMPORTS_DIR
%dk_call% dk_validate wsl.exe 	%dk_call% dk_depend wsl.exe

set CMAKE_GENERATOR="Unix Makefiles"





rem %dk_call% dk_depend build-essential)
rem %dk_call% dk_depend gcc)
rem %dk_call% dk_depend make
rem dk_findProgram(CMAKE_MAKE_PROGRAM 	make
rem %dk_call% dk_set CMAKE_GENERATOR 				"Unix Makefiles"
rem %dk_call% dk_set USR_BIN						"/usr/bin"
rem %dk_call% dk_set USR_LOCAL_BIN				"/usr/local/bin"
rem ###### CMAKE_C_COMPILER ######
rem if(EXISTS /usr/bin/gcc)
rem 	%dk_call% dk_set CMAKE_C_COMPILER			/usr/bin/gcc)
rem elseif(EXISTS /usr/local/bin/gcc)
rem 	%dk_call% dk_set CMAKE_C_COMPILER			/usr/local/bin/gcc)
rem )
rem ###### CMAKE_CXX_COMPILER ######
rem if(EXISTS /usr/bin/g++)
rem 	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/bin/g++)
rem elseif(EXISTS /usr/local/bin/g++)
rem 	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/local/bin/g++)
rem )
rem %dk_call% dk_set CMAKE_RC_COMPILER			%GCC_RC_COMPILER%
rem  %dk_call% dk_append CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu11
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu++17 -lstdc++fs)
rem  %dk_call% dk_append cmake_exe_LINKER_FLAGS	-static  &rem  -s)