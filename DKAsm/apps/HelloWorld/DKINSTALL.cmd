rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


:DKINSTALL
%setlocal%

	set "Target_App=HelloWorld"
	%dk_call% dk_debug "Target_App = %Target_App%"
	
	%dk_call% dk_validate Target_Tuple %dk_call% DKBuilder/Target_Tuple
	%dk_call% dk_validate Target_Type %dk_call% DKBuilder/Target_Type
		
	%dk_call% dk_echo "compiling %Target_App% - %Target_Type% for %Target_Tuple% . . ."
	%dk_call% dk_mkdir "%Target_Tuple%"
	%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
	%dk_call% dk_validate nasm_exe %dk_call% dk_depend nasm
	%dk_call% dk_validate gcc_exe %dk_call% dk_depend gcc
	
	if defined Windows_X86_Gcc (
		set "PATH=%msys2%/mingw32/bin;%PATH%"	
		%nasm_exe% -g -f elf32 main.asm -o "%Target_Tuple%%Target_App%.o"
	) else if defined Windows_X86_64_Gcc (
		set "PATH=%msys2%/mingw64/bin;%PATH%"
		%nasm_exe% -g -f elf64 main.asm -o "%Target_Tuple%/%Target_App%.o"		
	) else if defined Windows_X86_64_Ucrt (
		set "PATH=%msys2%/ucrt64/bin;%PATH%"
		%nasm_exe% -g -f elf64 main.asm -o "%Target_Tuple%/%Target_App%.o"
	)

	%gcc_exe% -static "%Target_Tuple%/%Target_App%.o" -o "%Target_Tuple%/%Target_App%.exe"
	%dk_call% dk_validate dumpbin_exe %dk_call% dk_depend dumpbin
	%dumpbin_exe% /ALL /RAWDATA:NONE /DISASM "%Target_Tuple%/%Target_App%.exe" > "%Target_Tuple%/%Target_App%.dump"
		

::### PE binary
::%nasm_exe% -f bin main.asm -o "%Target_Tuple%/%Target_App%.exe" 

::set "msys-2.0_dll=C:/Users/Administrator/Digital Knob/Development/3rdParty/msys2-base-x86_64-20241208/usr/bin/msys-2.0.dll"
::copy "%msys-2.0_dll%" "%CD%/msys-2.0.dll"
%endfunction%
