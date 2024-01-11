::https://www.msys2.org/wiki/Launchers/

@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

::cls
set "DIGITALKNOB=C:/Users/%USERNAME%/digitalknob"
set "DKBRANCH=%DIGITALKNOB%/Development"
set "MSYS2=%DKBRANCH%/3rdParty/msys2-x86_64-20221216"


:: env MSYSTEM=MINGW64		  "Set each NAME to VALUE in the environment and run COMMAND"
:: /usr/bin/bash -li 	 

::   -l				= "invoke a new shell process"    
::   -i 			= "make the shell interactive"
::   -c <command> 	= "run a command"


::%MSYS2%/usr/bin/env MSYSTEM=MSYS /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -li
%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc /c/Users/Administrator/digitalknob/Development/build.sh
::%MSYS2%/usr/bin/env MSYSTEM=CLANG32 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANG64 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=CLANGARM64 /usr/bin/bash -li
::%MSYS2%/usr/bin/env MSYSTEM=UCRT64 /usr/bin/bash -li
