::https://www.msys2.org/wiki/Launchers/

@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

::cls
set "DIGITALKNOB=C:/Users/%USERNAME%/digitalknob"
set "DKBRANCH_DIR=%DIGITALKNOB%/Development"
set "MSYS2=%DKBRANCH_DIR%/3rdParty/msys2-x86_64-20221216"

goto:main
:: env MSYSTEM=MINGW64  "Set each NAME to VALUE in the environment and run COMMAND"
:: /usr/bin/bash -li 	 

::   -l				= "invoke a new shell process"    
::   -i 			= "make the shell interactive"
::   -c <command> 	= "run a command"

:: Opening a new interactive shell
::%MSYS2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANG64 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash -li

:: Run a script in a new launched shell
::%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc /c/Users/Administrator/digitalknob/Development/build.sh

::###### MINGW64 ######
:console
	TITLE DigitalKnob - CONSOLE
	cls & echo You are in a Windows console environment & echo: & echo PATH = %PATH% & pause
goto:eof 

::###### MINGW64 ######
:mingw64
	TITLE DigitalKnob - MINGW64
	%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc "clear && echo You are in a MINGW64 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
goto:eof 

::###### Main ######
:main
	echo This will alernate between different shell environments & echo:
	pause
	
	call:console
	call:mingw64
	call:console
	
goto:eof 