@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::https://www.msys2.org/wiki/Launchers
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate MSYS2 "%dk_call% %DKIMPORTS_DIR%\msys2\dk_install.cmd"

goto main
:: env MSYSTEM=MINGW64  "Set each NAME to VALUE in the environment and run COMMAND"
:: /usr/bin/bash -li 	 

::   -l				= "invoke a new shell process"    
::   -i 			= "make the shell interactive"
::   -c <command> 	= "run a command"

:: Opening a new interactive shell
::%MSYS2%/usr/bin/env MSYSTEM=MSYS       /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=MINGW32    /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=MINGW64    /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANG32    /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANG64    /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=UCRT64     /usr/bin/bash -li

:: Run a script in a new launched shell
::%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc /c/Users/Administrator/digitalknob/Development/build.sh

::###### CMD ######
:CMD
	TITLE DigitalKnob - CONSOLE
	cls
	%dk_call% dk_echo "You are in a Windows cmd environment"
	%dk_call% dk_echo ""
	%dk_call% dk_echo "PATH = %PATH%"
	pause
%endfunction% 

::###### MSYS ######
:MSYS
	TITLE DigitalKnob - MSYS
	%MSYS2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash -lc ^
	"clear && echo You are in a MSYS terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANGARM64 ######
:CLANGARM64
	TITLE DigitalKnob - CLANGARM64
	%MSYS2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANGARM64 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANG32 ######
:CLANG32
	TITLE DigitalKnob - CLANG32
	%MSYS2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANG32 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANG64 ######
:CLANG64
	TITLE DigitalKnob - CLANG64
	%MSYS2%/usr/bin/env MSYSTEM=CLANG64 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANG64 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MINGW32 ######
:MINGW32
	TITLE DigitalKnob - MINGW32
	%MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc ^
	"clear && echo You are in a MINGW32 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MINGW64 ######
:MINGW64
	TITLE DigitalKnob - MINGW64
	%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc ^
	"clear && echo You are in a MINGW64 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction% 

::###### UCRT64 ######
:UCRT64
	TITLE DigitalKnob - UCRT64
	%MSYS2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash -lc ^
	"clear && echo You are in a UCRT64 terminal environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction% 

::###### Main ######
:main
	%dk_call% dk_echo "This will alernate between different shell environments"
	%dk_call% dk_echo ""
	pause
	
	call:CMD
	call:MSYS
	call:CLANGARM64
	call:CLANG32
	call:CLANG64
	call:MINGW32
	call:MINGW64
	call:UCRT64
%endfunction%
