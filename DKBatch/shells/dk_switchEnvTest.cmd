@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::https://www.msys2.org/wiki/Launchers
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_validate GIT "%dk_call% dk_installGit"
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
	%dk_call% dk_title "Digitalknob CMD"
	cls
	%dk_call% dk_echo "You are in a CMD environment"
	echo:
	%dk_call% dk_echo "PATH = %PATH%"
	pause
%endfunction% 

::###### GIT_CMD ######
:GIT_CMD
	%dk_call% dk_title "Digitalknob GIT_CMD"
	set "PATH=%GIT%\bin;%PATH%"
	cls
	echo You are in a GIT_CMD environment
	echo:
	echo PATH = %PATH% 
	pause
%endfunction%

::###### GIT_BASH ######
:GIT_BASH
	%dk_call% dk_title "Digitalknob GIT_BASH"
	%GIT%/usr/bin/env /usr/bin/bash -lc ^
	"clear && echo You are in a GIT_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MSYS_BASH ######
:MSYS_BASH
	%dk_call% dk_title "Digitalknob MSYS_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash -lc ^
	"clear && echo You are in a MSYS_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANGARM64 ######
:CLANGARM64_BASH
	%dk_call% dk_title "Digitalknob CLANGARM64_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANGARM64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANG32 ######
:CLANG32_BASH
	%dk_call% dk_title "Digitalknob CLANG32_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANG32_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### CLANG64 ######
:CLANG64_BASH
	%dk_call% dk_title "Digitalknob CLANG64_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=CLANG64 /usr/bin/bash -lc ^
	"clear && echo You are in a CLANG64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MINGW32 ######
:MINGW32_BASH
	%dk_call% dk_title "Digitalknob MINGW32_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc ^
	"clear && echo You are in a MINGW32_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction%

::###### MINGW64 ######
:MINGW64_BASH
	%dk_call% dk_title "Digitalknob MINGW64_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc ^
	"clear && echo You are in a MINGW64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
%endfunction% 

::###### UCRT64 ######
:UCRT64_BASH
	%dk_call% dk_title "Digitalknob UCRT64_BASH"
	%MSYS2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash -lc ^
	"clear && echo You are in a UCRT64_BASH environment && echo && echo PATH = $PATH && read -p 'press any key to continue' "
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
%endfunction%
