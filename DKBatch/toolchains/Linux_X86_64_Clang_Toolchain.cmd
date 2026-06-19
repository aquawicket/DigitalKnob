if NOT defined Linux_Host if NOT defined Windows_Host (
	exit /b 1
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "#################### Linux_X86_64_Clang_toolchain.cmd ######################"
%dk_call% dk_echo "############################################################################"



rem ###### dk_depend wsl ######
%dk_call% dk_validate DKIMPORTS_DIR	%dk_call% dk_DKIMPORTS_DIR
%dk_call% dk_validate wsl.exe 		%dk_call% dk_depend wsl.exe

rem ###### convert to wsl paths ######
%dk_call% dk_replaceAll "!DKSCRIPT_DIR!" "C:" "/mnt/c" DKSCRIPT_DIR
%wsl.exe% sh -c "export UPDATE=1 && export Target_App=%Target_App% && export Target_Tuple=%Target_Tuple% && export Target_Type=%Target_Type% && %DKSCRIPT_DIR:\=/%/DKBuilder.sh && exit $(true)


set CMAKE_GENERATOR="Unix Makefiles"





rem %dk_call% dk_depend build-essential)
rem %dk_call% dk_depend clang
rem %dk_call% dk_depend make	
rem dk_findProgram(CMAKE_MAKE_PROGRAM 	make
rem %dk_call% dk_set CMAKE_GENERATOR 				"Unix Makefiles"
rem %dk_call% dk_set USR_BIN						"/usr/bin"
rem %dk_call% dk_set USR_LOCAL_BIN				"/usr/local/bin"
rem ###### CMAKE_C_COMPILER ######
rem if(EXISTS /usr/bin/clang
rem 	%dk_call% dk_set CMAKE_C_COMPILER			/usr/bin/clang
rem elseif(EXISTS /usr/local/bin/clang
rem 	%dk_call% dk_set CMAKE_C_COMPILER			/usr/local/bin/clang
rem )
rem ###### CMAKE_CXX_COMPILER ######
rem if(EXISTS /usr/bin/clang++)
rem 	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/bin/clang++)
rem elseif(EXISTS /usr/local/bin/clang++)
rem 	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/local/bin/clang++)
rem )
rem %dk_call% dk_set CMAKE_RC_COMPILER			"%windres_exe%"
rem  %dk_call% dk_append CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
rem  %dk_call% dk_append cmake_exe_LINKER_FLAGS	-static  &rem  -s)
	