@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############ pacman ############
::# https://wiki.archlinux.org/title/Pacman
::# https://walterteng.com/using-zsh-on-windows

%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
%dk_call% dk_findProgram PACMAN_EXE pacman.exe "%MSYS2%/usr/bin"

::#	if NOT defined DKUPDATE (
::#		if EXIST %PACMAN_EXE% (
::#			%dk_call% dk_notice "PACMAN_EXE is already installed, returning"
::#			%return%
::#		)
::# )

::###### init the pacman keyring ######
::#dk_delete("%MSYS2_GPGDir%")

:: MSYS2_GPGDir = %MSYS2%/etc/pacman.d/gnupg
%dk_call% dk_validate MSYS2_GPGDir "%dk_call% dk_depend msys2"  
if NOT EXIST "%MSYS2_GPGDir%" (
	set "PATH=%MSYS2%/usr/bin;%PATH%"
	echo set "MAKEPKG_LIBRARY=%MSYS2%/usr/share/makepkg"
	%dk_call% dk_findProgram BASH_EXE bash "%MSYS2%/usr/bin"
	%dk_call% dk_exec !BASH_EXE! -c "pacman-key --init"
	%dk_call% dk_exec !BASH_EXE! -c "pacman-key --populate msys2"
	%dk_call% dk_killProcess gpg-agent.exe NO_HALT
)

%dk_call% dk_assertPath PACMAN_EXE

:: %MSYS2%/var/lib/pacman
if NOT EXIST "%MSYS2_DBPath%/sync" (
	%dk_call% dk_exec "%PACMAN_EXE%" -Syu --noconfirm
)

%dk_call% dk_FirewallAllow "pacman" "%PACMAN_EXE%"

::%dk_call% dk_installPackage pacman

