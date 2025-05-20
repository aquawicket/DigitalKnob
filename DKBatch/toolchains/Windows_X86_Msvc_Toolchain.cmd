::@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::######################################################################################################################################################

if(NOT Windows_Host)
	%return%
)

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################### Windows_X86_Msvc_Toolchain.cmd #######################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_depend 		visualstudio

%dk_call% dk_set 			CMAKE_GENERATOR				"%VS_GENERATOR%"
%dk_call% dk_set 			CMAKE_MAKE_PROGRAM 			"%VS_MAKE_PROGRAM%"

%dk_call% dk_set 			CMAKE_GENERATOR_PLATFORM	"%VS_X86_GENERATOR_PLATFORM%"
%dk_call% dk_set	 		CMAKE_CXX_COMPILER			"%VS_X86_COMPILER%"
%dk_call% dk_set 			CMAKE_C_COMPILER			"%VS_X86_COMPILER%"
%dk_call% dk_set 			CMAKE_DUMPBIN				"%VS_X86_DUMPBIN%"
%dk_call% dk_set 			CMAKE_LINKER				"%VS_X86_LINKER%"

rem %dk_call% dk_append 	DKCONFIGURE_FLAGS			"--build=i686-msvc"

rem %dk_call% dk_append 	CMAKE_C_FLAGS				/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj)   #/MACHINE:X86 /D_WIN32_WINNT=0x0600
rem %dk_call% dk_append 	CMAKE_CXX_FLAGS				/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X86 /D_WIN32_WINNT=0x0600
