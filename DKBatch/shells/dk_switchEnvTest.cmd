@rem shebang
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

::https://www.msys2.org/wiki/Launchers
%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
%dk_call% dk_validate GIT %dk_call% dk_depend git
%dk_call% dk_validate MSYS2 %dk_call% dk_depend msys2

goto main
rem env MSYSTEM=MINGW64  "Set each NAME to VALUE in the environment and run COMMAND"
rem /usr/bin/bash -li 	

rem   -l				= "invoke a new shell process"   
rem   -i 			= "make the shell interactive"
rem   -c <command> 	= "run a command"

rem Opening a new interactive shell
::%msys2%/usr/bin/env MSYSTEM=MSYS       /usr/bin/bash -li
::%msys2%/usr/bin/env MSYSTEM=MINGW32    /usr/bin/bash -li
::%msys2%/usr/bin/env MSYSTEM=MINGW64    /usr/bin/bash -li
::%msys2%/usr/bin/env MSYSTEM=CLANG32    /usr/bin/bash -li
::%msys2%/usr/bin/env MSYSTEM=CLANG64    /usr/bin/bash -li
::%msys2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -li
::%msys2%/usr/bin/env MSYSTEM=UCRT64     /usr/bin/bash -li

rem Run a script in a new launched shell
::%msys2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc /c/Users/Administrator/Digital Knob/Development/build.sh

::###### CMD ######
:CMD
	%dk_call% dk_title "Digitalknob CMD"
	%dk_call% dk_clearScreen
	%dk_call% dk_echo "You are in a CMD environment"
	echo.
	%dk_call% dk_echo "PATH = %PATH%"
	pause
%endfunction%

::###### GIT_CMD ######
:GIT_CMD
	%dk_call% dk_title "Digitalknob GIT_CMD"
	set "PATH=%git%\bin;%PATH%"
	%dk_call% dk_clearScreen
	echo You are in a GIT_CMD environment
	echo.
	echo PATH = %PATH%
	pause
%endfunction%

::###### GIT_BASH ######
:GIT_BASH
	%dk_call% dk_title "Digitalknob GIT_BASH"
	%git%/usr/bin/env /usr/bin/bash -lc ^
	"clear && echo You are in a GIT_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MSYS_BASH ######
:MSYS_BASH
	%dk_call% dk_title "Digitalknob MSYS_BASH"
	%msys2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash -lc ^
	"clear && echo You are in a MSYS_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANGARM64 ######
:CLANGARM64_BASH
	%dk_call% dk_title "Digitalknob CLANGARM64_BASH"
	%msys2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANGARM64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANG32 ######
:CLANG32_BASH
	%dk_call% dk_title "Digitalknob CLANG32_BASH"
	%msys2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANG32_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANG64 ######
:CLANG64_BASH
	%dk_call% dk_title "Digitalknob CLANG64_BASH"
	%msys2%/usr/bin/env MSYSTEM=CLANG64 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANG64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MINGW32 ######
:MINGW32_BASH
	%dk_call% dk_title "Digitalknob MINGW32_BASH"
	%msys2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc ^
	"clear && echo You are in a MINGW32_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MINGW64 ######
:MINGW64_BASH
	%dk_call% dk_title "Digitalknob MINGW64_BASH"
	%msys2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc ^
	"clear && echo You are in a MINGW64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### UCRT64 ######
:UCRT64_BASH
	%dk_call% dk_title "Digitalknob UCRT64_BASH"
	%msys2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash -lc ^
	"clear && echo You are in a UCRT64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### WSL_DEBIAN ######
:WSL_DEBIAN
	%dk_call% dk_title "Digitalknob WSL_DEBIAN"
	%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
	"%wsl.exe%" -d Debian --exec ^ 
	"clear && echo You are in a WSL_DEBIAN environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### Main ######
:main
	%dk_call% dk_echo "This will alernate between different shell environments"
	%dk_call% dk_echo ""
	pause
	
	call:CMD
	call:GIT_CMD
	call:GIT_BASH
	call:MSYS_BASH
	call:CLANGARM64_BASH
	call:CLANG32_BASH
	call:CLANG64_BASH
	call:MINGW32_BASH
	call:MINGW64_BASH
	call:UCRT64_BASH
	call:WSL_DEBIAN
%endfunction%
