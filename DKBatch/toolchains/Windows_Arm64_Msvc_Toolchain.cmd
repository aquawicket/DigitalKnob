if not defined Windows_Host (
	exit /b 1
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################## Windows_Arm64_Msvc_Toolchain.cmd #######################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_set  MULTI_CONFIG		1
(set CMAKE_GENERATOR="Visual Studio 17 2022" -A Arm64)




::%dk_call% dk_depend 		visualstudio
::%dk_call% dk_set 			CMAKE_GENERATOR				%VS_GENERATOR%
::%dk_call% dk_set 			CMAKE_MAKE_PROGRAM 			%VS_MAKE_PROGRAM%
::%dk_call% dk_set 			CMAKE_GENERATOR_PLATFORM	%VS_X86_64_GENERATOR_PLATFORM%
::%dk_call% dk_set 			CMAKE_CXX_COMPILER			%VS_X86_64_COMPILER%
::%dk_call% dk_set 			CMAKE_C_COMPILER			%VS_X86_64_COMPILER%
::%dk_call% dk_set 			CMAKE_DUMPBIN				%VS_X86_64_DUMPBIN%
::%dk_call% dk_set 			CMAKE_LINKER				%VS_X86_64_LINKER%
rem  %dk_call% dk_append	DKCONFIGURE_FLAGS			--build=x86_64-w64-msvc
rem  %dk_call% dk_append 	CMAKE_C_FLAGS				/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj)   #/MACHINE:X64 /D_WIN32_WINNT=0x0600
rem  %dk_call% dk_append 	CMAKE_CXX_FLAGS				/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X64 /D_WIN32_WINNT=0x0600
