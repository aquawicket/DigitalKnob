@echo off

set "W_MSYS2=C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-base-x86_64-20241208"
set "U_MSYS2=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-base-x86_64-20241208"
::set "MSYS2_GPGDir=%MSYS2%/etc/pacman.d/gnupg"
set "BASH_EXE=%W_MSYS2%/usr/bin/bash.exe"
set "PACMAN_KEY=%U_MSYS2%/usr/bin/pacman-key"
set "MAKEPKG_LIBRARY=%W_MSYS2%/usr/share/makepkg"

set "PATH=%W_MSYS2%/usr/bin;%PATH%"
%BASH_EXE% -c "export PATH=%U_MSYS2%:$PATH; cd %U_MSYS2%; %PACMAN_KEY% --init"


pause