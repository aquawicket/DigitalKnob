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


rem https://www.msys2.org/wiki/Launchers
%dk_call% dk_installMsys2.cmd
rem set "MSYS2=%DKBRANCH_DIR%/3rdParty/msys2-x86_64-20221216"

goto main
rem  env MSYSTEM=MINGW64  "Set each NAME to VALUE in the environment and run COMMAND"
rem  /usr/bin/bash -li

rem    -l				= "invoke a new shell process"
rem    -i 			= "make the shell interactive"
rem    -c <command> 	= "run a command"

rem  Opening a new interactive shell
rem %msys2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash -li
rem %msys2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -li
rem %msys2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -li
rem %msys2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash -li
rem %msys2%/usr/bin/env MSYSTEM=CLANG64 /usr/bin/bash -li
rem %msys2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -li
rem %msys2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash -li

rem  Run a script in a new launched shell
rem %msys2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc /c/Users/Administrator/Digital Knob/Development/build.sh

rem ###### MINGW64 ######
:console
	cls
	%dk_call% dk_echo "You are in a Windows console environment"
	%dk_call% dk_echo ""
	%dk_call% dk_echo "PATH = %PATH%"
	pause
%endfunction%

rem ###### MINGW64 ######
:mingw64
	%msys2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc "clear && echo You are in a MINGW64 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

rem ###### Main ######
:main
	%dk_call% dk_echo "This will alernate between different shell environments"
	%dk_call% dk_echo ""
	pause
	
	call:console
	call:mingw64
	call:console
%endfunction%
