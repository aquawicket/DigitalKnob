::@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::######################################################################################################################################################

if(NOT Linux_Host)
	%return%
)

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "###################### Linux_X86_64_Gcc_Toolchain.cmd ####################"
%dk_call% dk_echo "############################################################################"

rem %dk_call% dk_depend build-essential)
%dk_call% dk_depend gcc)
%dk_call% dk_depend make
	
dk_findProgram(CMAKE_MAKE_PROGRAM 	make
%dk_call% dk_set CMAKE_GENERATOR 				"Unix Makefiles"

rem %dk_call% dk_set USR_BIN						"/usr/bin"
rem %dk_call% dk_set USR_LOCAL_BIN				"/usr/local/bin"

###### CMAKE_C_COMPILER ######
if(EXISTS /usr/bin/gcc)
	%dk_call% dk_set CMAKE_C_COMPILER			/usr/bin/gcc)
elseif(EXISTS /usr/local/bin/gcc)
	%dk_call% dk_set CMAKE_C_COMPILER			/usr/local/bin/gcc)
)

###### CMAKE_CXX_COMPILER ######
if(EXISTS /usr/bin/g++)
	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/bin/g++)
elseif(EXISTS /usr/local/bin/g++)
	%dk_call% dk_set CMAKE_CXX_COMPILER		/usr/local/bin/g++)
)

rem %dk_call% dk_set CMAKE_RC_COMPILER			%GCC_RC_COMPILER%
rem  %dk_call% dk_append CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu11
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_X86_64 -std=gnu++17 -lstdc++fs)
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS	-static  &rem  -s)
	