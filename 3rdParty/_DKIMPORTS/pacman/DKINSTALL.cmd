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


rem ############ pacman ############
rem # https://wiki.archlinux.org/title/Pacman
rem # https://walterteng.com/using-zsh-on-windows
rem #
:DKINSTALL
%setlocal%

	%dk_call% dk_validate MSYS2 %dk_call% dk_depend msys2
	set "pacman_exe=%msys2%/usr/bin/pacman.exe"

	rem #	if NOT defined DKUPDATE (
	rem #		if EXIST "%pacman_exe%" (
	rem #			%dk_call% dk_notice "pacman_exe is already installed, returning"
	rem #			%return%
	rem #		)
	rem # )

	rem ###### init the pacman keyring ######
	rem #dk_delete("%msys2_GPGDir%")

	rem  msys2_GPGDir = %msys2%/etc/pacman.d/gnupg
	%dk_call% dk_validate msys2_GPGDir %dk_call% dk_depend msys2  

	if NOT EXIST "%msys2_GPGDir%" (
		set "PATH=%msys2%/usr/bin;%PATH%"
		rem echo set "MAKEPKG_LIBRARY=%msys2%/usr/share/makepkg"
		set "bash_exe=%msys2%/usr/bin/bash.exe"
		%dk_call% dk_exec "!bash_exe!" -c "pacman-key --init"
		%dk_call% dk_exec "!bash_exe!" -c "pacman-key --populate msys2"
		%dk_call% dk_killProcess gpg-agent.exe NO_HALT
	)

	%dk_call% dk_assertPath "%pacman_exe%"

	if NOT EXIST "%msys2_DBPath%/sync" (
		%dk_call% dk_exec "%pacman_exe%" -Syu --noconfirm
	)

	:return
	%dk_call% dk_firewallAllow "%pacman_exe%"
	endlocal & (
		set "pacman_exe=%pacman_exe%"
	)
	rem %dk_call% dk_debug "pacman_exe = %pacman_exe%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate pacman %dk_call% dk_depend pacman
	%dk_call% dk_debug "pacman = %pacman%"
	%dk_call% dk_debug "pacman_exe = %pacman_exe%"
	
%endfunction%